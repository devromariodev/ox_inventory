import React, { useCallback, useEffect, useRef, useState } from 'react';
import {
  FloatingFocusManager,
  FloatingOverlay,
  FloatingPortal,
  useDismiss,
  useFloating,
  useInteractions,
  useTransitionStyles,
} from '@floating-ui/react';
import { Locale } from '../../store/locale';
import { resetTheme, setUiConfig, THEME_PRESET_NAMES, THEME_PRESETS, UiConfig } from '../../store/uiConfig';
import {
  getNumberPref,
  getPref,
  getExposedPreferences,
  NumberPrefDef,
  PrefKey,
  PrefValue,
  prefDescriptionKey,
  prefLabelKey,
  setPrefs,
} from '../../store/preferences';
import { flushPrefs, persistPrefs, PREF_CHANGE_EVENT } from '../../helpers';
import { ThemeColors } from '../../typings/uiConfig';
import { fetchNui } from '../../utils/fetchNui';
import { CloseIcon } from '../utils/icons';

/**
 * NewCity (#88, Fase 3) — o painel de ajustes tinha 5 abas e ~40 preferências
 * (espaçamento, fontes, contraste, tooltips, ordenação, cores soltas…). Decisão do
 * dono (2026-08-27): fica **cor e tamanho**, nada mais. Uma cara só para o servidor
 * inteiro, e nada aqui que o jogador precise configurar para jogar.
 *
 * O que sumiu daqui NÃO some do inventário: cada preferência continua valendo o
 * padrão dela (o motor de preferências aplica os defaults ao carregar). Tirar a
 * DEFINIÇÃO, e não só a tela, apagaria o padrão junto — e a interface passaria a
 * se comportar como se tudo estivesse desligado. Ver `EXPOSED_PREFS` no store.
 */
interface Props {
  visible: boolean;
  setVisible: React.Dispatch<React.SetStateAction<boolean>>;
}

const SAVE_DEBOUNCE = 400;

type SaveStatus = 'idle' | 'saving' | 'saved' | 'error';

const decimalsForStep = (step: number): number => {
  if (!Number.isFinite(step) || step >= 1) return 0;

  const text = String(step);
  const dot = text.indexOf('.');

  return dot === -1 ? 0 : Math.min(4, text.length - dot - 1);
};

const formatNumber = (def: NumberPrefDef, value: number): string => {
  const text = value.toFixed(decimalsForStep(def.step));

  return def.unit ? `${text} ${def.unit}` : text;
};

type PrefWriter = (key: PrefKey, value: PrefValue) => void;

/** Só o tipo `number` sobrou: as preferências expostas são réguas (tamanho). */
const PrefRow: React.FC<{ def: NumberPrefDef; onChange: PrefWriter }> = ({ def, onChange }) => {
  const label = Locale[prefLabelKey(def.key)] || def.label;
  const description = Locale[prefDescriptionKey(def.key)] || def.description;

  return (
    <div className="settings-pref" data-pref={def.key}>
      <div className="settings-pref-head">
        <span className="settings-pref-label">{label}</span>
        <span className="settings-pref-value">{formatNumber(def, getNumberPref(def.key))}</span>
      </div>

      {description && <p className="settings-pref-desc">{description}</p>}

      <input
        className="settings-range"
        type="range"
        min={def.min}
        max={def.max}
        step={def.step}
        value={getNumberPref(def.key)}
        aria-label={label}
        aria-valuetext={formatNumber(def, getNumberPref(def.key))}
        onChange={(event) => onChange(def.key, Number(event.target.value))}
      />
    </div>
  );
};

const SettingsPanel: React.FC<Props> = ({ visible, setVisible }) => {
  const { refs, context } = useFloating({
    open: visible,
    onOpenChange: setVisible,
  });

  const dismiss = useDismiss(context, {
    outsidePressEvent: 'mousedown',
    escapeKey: false,
  });

  const { isMounted, styles } = useTransitionStyles(context);
  const { getFloatingProps } = useInteractions([dismiss]);

  const [themeName, setThemeName] = useState<string>(UiConfig.theme.name);
  const [status, setStatus] = useState<SaveStatus>('idle');
  const [, setRevision] = useState(0);

  const mountedRef = useRef(true);
  const openRef = useRef(visible);
  const timerRef = useRef<number | undefined>(undefined);
  const themePendingRef = useRef<{ name: string; colors: ThemeColors } | undefined>(undefined);
  const swallowKeyupRef = useRef(false);

  openRef.current = visible;

  const settle = useCallback((saved: boolean) => {
    if (mountedRef.current) setStatus(saved ? 'saved' : 'error');
  }, []);

  const flush = useCallback(() => {
    if (timerRef.current !== undefined) {
      clearTimeout(timerRef.current);
      timerRef.current = undefined;
    }

    flushPrefs();

    const theme = themePendingRef.current;

    themePendingRef.current = undefined;

    if (!theme) return;

    if (mountedRef.current) setStatus('saving');

    fetchNui<boolean | undefined>('saveTheme', theme)
      .then((ok) => settle(!!ok))
      .catch(() => settle(false));
  }, [settle]);

  const arm = useCallback(() => {
    if (timerRef.current !== undefined) clearTimeout(timerRef.current);

    timerRef.current = window.setTimeout(flush, SAVE_DEBOUNCE);
  }, [flush]);

  const commit = useCallback(
    (name: string, colors: ThemeColors) => {
      setThemeName(name);
      setUiConfig({ theme: { name, colors } });

      themePendingRef.current = { name, colors };
      arm();
    },
    [arm]
  );

  const commitPrefs = useCallback(
    (partial: Record<string, PrefValue>) => {
      setPrefs(partial);

      if (mountedRef.current) setStatus('saving');

      persistPrefs(partial, settle);

      setRevision((current) => current + 1);
    },
    [settle]
  );

  const onPrefChange = useCallback<PrefWriter>(
    (key, value) => {
      if (getPref(key) === value) return;

      commitPrefs({ [key]: value });
    },
    [commitPrefs]
  );

  useEffect(() => {
    if (!visible) return;

    setThemeName(UiConfig.theme.name);
    setStatus('idle');
  }, [visible]);

  useEffect(() => {
    if (visible) return;

    flush();
  }, [visible, flush]);

  useEffect(() => {
    if (!visible) return;

    fetchNui('lockControls', true).catch(() => {});

    return () => {
      fetchNui('lockControls', false).catch(() => {});
    };
  }, [visible]);

  useEffect(() => {
    mountedRef.current = true;

    return () => {
      mountedRef.current = false;
      flush();
    };
  }, [flush]);

  useEffect(() => {
    if (!visible) return;

    const onChanged = () => setRevision((current) => current + 1);

    window.addEventListener(PREF_CHANGE_EVENT, onChanged);

    return () => window.removeEventListener(PREF_CHANGE_EVENT, onChanged);
  }, [visible]);

  useEffect(() => {
    const onKeyDown = (event: KeyboardEvent) => {
      if (event.code !== 'Escape' || !openRef.current) return;

      event.preventDefault();
      event.stopImmediatePropagation();
      swallowKeyupRef.current = true;
      setVisible(false);
    };

    const onKeyUp = (event: KeyboardEvent) => {
      if (event.code !== 'Escape' || !swallowKeyupRef.current) return;

      swallowKeyupRef.current = false;
      event.preventDefault();
      event.stopImmediatePropagation();
    };

    window.addEventListener('keydown', onKeyDown, true);
    window.addEventListener('keyup', onKeyUp, true);

    return () => {
      window.removeEventListener('keydown', onKeyDown, true);
      window.removeEventListener('keyup', onKeyUp, true);
    };
  }, [setVisible]);

  const applyPreset = (name: string) => {
    const preset = THEME_PRESETS[name];

    if (!preset) return;

    commit(name, preset);
  };

  /** Volta cor E tamanho ao padrão — com uma tela só, "padrão" é tudo. */
  const onReset = () => {
    const theme = resetTheme();

    commit(theme.name, theme.colors);

    const defaults: Record<string, PrefValue> = {};

    for (const def of getExposedPreferences()) defaults[def.key] = def.default;

    commitPrefs(defaults);
  };

  const statusLabel =
    status === 'saving'
      ? Locale.ui_settings_saving || Locale.ui_theme_saving || 'Salvando…'
      : status === 'saved'
      ? Locale.ui_settings_saved || Locale.ui_theme_saved || 'Salvo'
      : status === 'error'
      ? Locale.ui_settings_save_failed || Locale.ui_theme_save_failed || 'Não salvou neste servidor'
      : '';

  return (
    <>
      {isMounted && (
        <FloatingPortal>
          <FloatingOverlay lockScroll className="useful-controls-dialog-overlay" data-open={visible} style={styles}>
            <FloatingFocusManager context={context}>
              <div
                ref={refs.setFloating}
                {...getFloatingProps()}
                className="useful-controls-dialog settings-dialog"
                style={styles}
              >
                <div className="useful-controls-dialog-title">
                  <p>{Locale.ui_settings || 'Ajustes'}</p>
                  <div
                    className="useful-controls-dialog-close settings-dialog-close"
                    onClick={() => setVisible(false)}
                  >
                    <CloseIcon />
                  </div>
                </div>

                <div className="settings-body">
                  <div className="settings-tabpanel">
                    <section className="settings-section">
                      <p className="settings-section-title">{Locale.ui_theme_presets || 'Cor'}</p>
                      <div className="settings-presets">
                        {THEME_PRESET_NAMES.map((name) => {
                          const preset = THEME_PRESETS[name];

                          if (!preset) return null;

                          return (
                            <button
                              key={name}
                              type="button"
                              className={`settings-preset${themeName === name ? ' settings-preset-active' : ''}`}
                              onClick={() => applyPreset(name)}
                              aria-pressed={themeName === name}
                            >
                              <span
                                className="settings-preset-swatch"
                                style={{
                                  background: `linear-gradient(135deg, ${preset.mainColor} 0%, ${preset.secondaryColor} 100%)`,
                                }}
                              />
                              <span className="settings-preset-label">{Locale[`ui_theme_${name}`] || name}</span>
                            </button>
                          );
                        })}
                      </div>
                    </section>

                    <section className="settings-section">
                      <div className="settings-prefs">
                        {getExposedPreferences().map((def) => (
                          <PrefRow key={def.key} def={def} onChange={onPrefChange} />
                        ))}
                      </div>
                    </section>
                  </div>
                </div>

                <div className="settings-footer">
                  <span className="settings-status">{statusLabel}</span>
                  <div className="settings-footer-actions">
                    <button type="button" className="settings-button" onClick={onReset}>
                      {Locale.ui_theme_reset || 'Voltar ao padrão'}
                    </button>
                    <button
                      type="button"
                      className="settings-button settings-button-primary"
                      onClick={() => setVisible(false)}
                    >
                      {Locale.ui_close || 'Fechar'}
                    </button>
                  </div>
                </div>
              </div>
            </FloatingFocusManager>
          </FloatingOverlay>
        </FloatingPortal>
      )}
    </>
  );
};

export default SettingsPanel;
