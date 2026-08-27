import React, { useEffect, useRef, useState } from 'react';
import { Locale } from '../../store/locale';
import { prefOptionKey, SORT_MODES, SortMode } from '../../store/preferences';
import { getSortMode, isSortAvailable, PREF_CHANGE_EVENT } from '../../helpers';
import Dropdown from '../utils/Dropdown';

/**
 * NewCity (#88, Fase 3) — sobrou a ORDENAÇÃO.
 *
 * As categorias (arma / médico / comida / roupa) e a busca por nome saíram por
 * decisão do dono (2026-08-27): a grade cabe inteira na tela, então filtrar e
 * procurar era ferramenta para um problema que não temos — e cada uma trazia
 * consigo uma tabela de "o que conta como comida" que ninguém mantinha.
 *
 * A ordenação continua só onde ela FUNCIONA: o painel de slots (loja e bancada).
 * Na grade ela é inerte por natureza — um item ocupa várias células a partir do
 * seu slot, e reordenar só a exibição rasgaria o formato dele.
 */
interface InventoryFiltersProps {
  sort?: React.ReactNode;
}

const InventoryFilters: React.FC<InventoryFiltersProps> = ({ sort }) =>
  sort ? (
    <div className="filters">
      <div className="filters-sort">
        <span className="filters-sort-label">{Locale.ui_sort || 'Ordenar'}</span>
        {sort}
      </div>
    </div>
  ) : null;

export default InventoryFilters;

export const usePrefsRevision = (): number => {
  const [revision, setRevision] = useState(0);

  useEffect(() => {
    const onChange = () => setRevision((current) => current + 1);

    window.addEventListener(PREF_CHANGE_EVENT, onChange);

    return () => window.removeEventListener(PREF_CHANGE_EVENT, onChange);
  }, []);

  return revision;
};

const SORT_LABELS: Record<SortMode, string> = {
  slot: 'Slot',
  name: 'Nome',
  weight: 'Peso',
  rarity: 'Raridade',
  count: 'Quantidade',
};

const GRID_UNAVAILABLE_FALLBACK =
  'Ordenar não vale na grade: um item ocupa várias células a partir do slot dele, ' +
  'então reordenar só a exibição rasgaria o formato.';

export const usePanelSortMode = (): [SortMode, (next: SortMode) => void] => {
  const prefsRevision = usePrefsRevision();
  const preferred = getSortMode();
  const [mode, setMode] = useState<SortMode>(preferred);
  const lastPreferred = useRef(preferred);

  useEffect(() => {
    if (lastPreferred.current === preferred) return;

    lastPreferred.current = preferred;
    setMode(preferred);
  }, [preferred, prefsRevision]);

  return [mode, setMode];
};

interface InventorySortProps {
  value: SortMode;
  onChange: (next: SortMode) => void;
}

export const InventorySort: React.FC<InventorySortProps> = ({ value, onChange }) => {
  const available = isSortAvailable();

  const label = Locale.ui_pref_sortMode || 'Ordenar por';
  const title = available ? label : Locale.ui_sort_unavailable_grid || GRID_UNAVAILABLE_FALLBACK;

  const options = SORT_MODES.map((option) => ({
    value: option,
    label: Locale[prefOptionKey('sortMode', option)] || SORT_LABELS[option],
  }));

  return (
    <Dropdown
      className="inventory-sort"
      value={value}
      options={options}
      disabled={!available}
      title={title}
      ariaLabel={label}
      onChange={(next) => onChange(next as SortMode)}
    />
  );
};
