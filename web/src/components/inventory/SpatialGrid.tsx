import React, { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useDragLayer, useDrop } from 'react-dnd';
import { DragSource, Inventory, InventoryType, SlotWithItem } from '../../typings';
import { getGridOccupancy, getTotalWeight, isSlotWithItem } from '../../helpers';
import { useAppDispatch, useAppSelector } from '../../store';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { togglePanelCollapsed, usePanelCollapsed } from '../../hooks/usePanelCollapse';
import { fetchNui } from '../../utils/fetchNui';
import { closeTooltip } from '../../store/tooltip';
import { onBuy } from '../../dnd/onBuy';
import {
  getGridDimensions,
  isBlockedContainerMove,
  onSpatialDrop,
  resolveSpatialTarget,
  SpatialTarget,
} from '../../dnd/onSpatialDrop';
import useRotateKey from '../../hooks/useRotateKey';
import SpatialSlot, { spatialCellStyle } from './SpatialSlot';
import { BagIcon, GridIcon, WeightIcon } from '../utils/icons';

const formatWeight = (weight: number): string => {
  if (weight >= 1000) return `${(weight / 1000).toFixed(1)}kg`;

  return `${Math.round(weight)}g`;
};

const getWeightColorClass = (percent: number): string => {
  if (percent >= 100) return 'weight-critical';
  if (percent >= 80) return 'weight-warning';

  return '';
};

const resolveCellDrop = (
  source: DragSource,
  inventory: Inventory,
  cursorCell: number,
  rotated: boolean
): SpatialTarget | undefined => {
  if (!source?.item) return;
  if (isBlockedContainerMove(source, inventory)) return;

  const sameInventory = source.inventory === inventory.type;

  const dropRotated =
    source.inventory === InventoryType.SHOP
      ? source.rotated === true
      : rotated;

  const target = resolveSpatialTarget(
    source,
    inventory,
    cursorCell,
    dropRotated,
    sameInventory ? source.item.slot : undefined
  );

  if (!target) return;
  if (sameInventory && target.slot === source.item.slot) return;

  return target;
};

const SpatialGrid: React.FC<{ inventory: Inventory }> = ({ inventory }) => {
  const dispatch = useAppDispatch();
  const [hoverCell, setHoverCell] = useState<number | null>(null);
  const isBusy = useAppSelector((state) => state.inventory.isBusy);

  const isPlayer = inventory.type === 'player';

  const weight = useMemo(
    () => (inventory.maxWeight !== undefined ? Math.floor(getTotalWeight(inventory.items) * 1000) / 1000 : 0),
    [inventory.maxWeight, inventory.items]
  );

  const weightPercent = useMemo(
    () => (inventory.maxWeight ? (weight / inventory.maxWeight) * 100 : 0),
    [weight, inventory.maxWeight]
  );

  const itemCount = useMemo(() => inventory.items.filter((item) => item.name).length, [inventory.items]);

  const { cols, rows, cells } = useMemo(() => getGridDimensions(inventory), [inventory.slots, inventory.type]);

  const occupancy = useMemo(() => getGridOccupancy(inventory.items, cols, rows), [inventory.items, cols, rows]);

  const cellsStyle = useMemo(
    () =>
      ({
        gridTemplateColumns: `repeat(${cols}, var(--ox-cell))`,
        '--ox-cell-fit': `calc((50vw - var(--ox-centre-reserve) / 2 - var(--ox-gap-panel) - 2 * var(--ox-spatial-pad) - ${
          cols - 1
        } * var(--ox-cell-gap) - 0.2vh) / ${cols})`,
      } as React.CSSProperties),
    [cols]
  );

  const { dragSource, isDragging } = useDragLayer((monitor) => ({
    dragSource: monitor.getItem() as DragSource | null,
    isDragging: monitor.isDragging(),
  }));

  const rotated = useRotateKey(isDragging ? dragSource : null);

  // NewCity (#88, Fase 4 — P1): ANTES cada celula da grade era um alvo de
  // arrastar do react-dnd. Uma grade de 10x5 com a mochila aberta passava de 100
  // alvos, e QUALQUER mudanca (mexer um item, girar com R) refazia o registro de
  // TODOS eles. Agora o alvo e um so, o da grade inteira, e a celula sob o cursor
  // sai de conta: posicao do ponteiro menos o canto da grade, dividido pelo passo.
  //
  // A conta usa o tamanho REAL medido no navegador (getBoundingClientRect + o
  // espacamento calculado), e nao o valor do CSS — a interface inteira escala com
  // a altura da tela e com o "Tamanho" que o jogador escolhe. Mede-se uma vez por
  // arrasto; entre um arrasto e outro a grade nao muda de tamanho.
  const cellsRef = useRef<HTMLDivElement | null>(null);
  const metricsRef = useRef<{ left: number; top: number; stepX: number; stepY: number } | null>(null);

  const measureCells = useCallback(() => {
    const el = cellsRef.current;

    if (!el) return null;

    const rect = el.getBoundingClientRect();

    if (!rect.width || !rect.height) return null;

    const style = getComputedStyle(el);
    const gapX = parseFloat(style.columnGap) || 0;
    const gapY = parseFloat(style.rowGap) || 0;

    return {
      left: rect.left,
      top: rect.top,
      stepX: (rect.width + gapX) / cols,
      stepY: (rect.height + gapY) / rows,
    };
  }, [cols, rows]);

  const cellFromPoint = useCallback(
    (x: number, y: number): number | null => {
      const m = metricsRef.current ?? (metricsRef.current = measureCells());

      if (!m || m.stepX <= 0 || m.stepY <= 0) return null;

      const col = Math.floor((x - m.left) / m.stepX);
      const row = Math.floor((y - m.top) / m.stepY);

      if (col < 0 || col >= cols || row < 0 || row >= rows) return null;

      return row * cols + col;
    },
    [measureCells, cols, rows]
  );

  const [{ isOverGrid }, dropGrid] = useDrop<DragSource, void, { isOverGrid: boolean }>(
    () => ({
      accept: 'SLOT',
      collect: (monitor) => ({ isOverGrid: monitor.isOver() }),
      hover: (_source, monitor) => {
        const offset = monitor.getClientOffset();

        if (!offset) return;

        const index = cellFromPoint(offset.x, offset.y);

        if (index === null) return;

        setHoverCell((previous) => (previous === index ? previous : index));
      },
      canDrop: (source, monitor) => {
        if (inventory.type === InventoryType.SHOP) return false;

        const offset = monitor.getClientOffset();

        if (!offset) return false;

        const index = cellFromPoint(offset.x, offset.y);

        if (index === null) return false;

        const target = resolveCellDrop(source, inventory, index, rotated);

        return target !== undefined && target.valid;
      },
      drop: (source, monitor) => {
        const offset = monitor.getClientOffset();

        if (!offset) return;

        const index = cellFromPoint(offset.x, offset.y);

        if (index === null) return;

        const target = resolveCellDrop(source, inventory, index, rotated);

        if (!target || !target.valid) return;

        dispatch(closeTooltip());

        const dropTarget = { inventory: inventory.type, item: { slot: target.slot } };

        if (source.inventory === InventoryType.SHOP) {
          onBuy(source, dropTarget);
        } else {
          onSpatialDrop(source, dropTarget, rotated);
        }
      },
    }),
    [inventory, rotated, cellFromPoint, dispatch]
  );

  useEffect(() => {
    metricsRef.current = null;

    if (!isDragging) setHoverCell(null);
  }, [isDragging]);

  const preview = useMemo(() => {
    if (!isDragging || !isOverGrid || hoverCell === null || !dragSource?.item) return;

    return resolveCellDrop(dragSource, inventory, hoverCell, rotated);
  }, [isDragging, isOverGrid, hoverCell, dragSource, inventory, rotated]);

  const items = useMemo(
    () =>
      inventory.items.filter(
        (item): item is SlotWithItem => isSlotWithItem(item) && item.slot > 0 && item.slot <= cells
      ),
    [inventory.items, cells]
  );

  const isCollapsed = usePanelCollapsed(inventory.id);

  const fallbackTitle = isPlayer
    ? Locale.ui_inventory || 'Inventory'
    : inventory.type === InventoryType.BACKPACK
    ? Locale.ui_backpack || 'Backpack'
    : Locale.ui_other_inventory || 'Other Inventory';

  return (
    <div
      className={`inventory-grid-wrapper${isCollapsed ? ' collapsed' : ''}`}
      style={{ pointerEvents: isBusy ? 'none' : 'auto' }}
    >
      <div className="inventory-grid-header-wrapper">
        {!isPlayer && (
          <button
            type="button"
            className={`panel-collapse${isCollapsed ? ' is-collapsed' : ''}`}
            aria-label={isCollapsed ? 'Expand' : 'Collapse'}
            onClick={() => togglePanelCollapsed(inventory.id)}
          >
            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" strokeWidth={2} strokeLinecap="round" strokeLinejoin="round"><path d="m6 9 6 6 6-6" /></svg>
          </button>
        )}
        <div className="panel-icon">{isPlayer ? <GridIcon /> : <BagIcon />}</div>
        <div className="panel-title">{inventory.label || fallbackTitle}</div>
        <div className="panel-description">
          {itemCount} {Locale.ui_items || 'items'}
        </div>
        {inventory.maxWeight !== undefined && inventory.maxWeight > 0 && (
          <div className={`inventory-weight-display ${getWeightColorClass(weightPercent)}`}>
            <WeightIcon />
            <span>
              {formatWeight(weight)} / {formatWeight(inventory.maxWeight)}
            </span>
          </div>
        )}
      </div>

      <div ref={dropGrid} className={`spatial-grid ${isDragging ? 'spatial-grid-dragging' : ''}`}>
        <div ref={cellsRef} className="spatial-grid-cells" style={cellsStyle}>
          {Array.from({ length: cells }, (_, index) => (
            <div
              key={`cell-${index}`}
              className={`spatial-cell${occupancy[index] !== null ? ' spatial-cell-covered' : ''}`}
            />
          ))}

          {items.map((item) => (
            <SpatialSlot
              key={`${inventory.type}-${inventory.id}-${item.slot}`}
              item={item}
              cols={cols}
              inventoryType={inventory.type}
              inventoryGroups={inventory.groups}
              inventoryId={inventory.id}
            />
          ))}

          {preview && (
            <div
              className={`spatial-ghost ${preview.valid ? 'spatial-drop-valid' : 'spatial-drop-invalid'}`}
              style={spatialCellStyle(
                preview.anchor % cols,
                Math.floor(preview.anchor / cols),
                preview.width,
                preview.height
              )}
            />
          )}
        </div>
      </div>
    </div>
  );
};

export default SpatialGrid;
