import React, { useEffect, useMemo, useRef, useState } from 'react';
import { Inventory, InventoryType, Slot } from '../../typings';
import InventorySlot from './InventorySlot';
import CircularWeight from '../utils/CircularWeight';
import { getFavourites, getPinFavourites, getTotalWeight, sortSlots } from '../../helpers';
import { getNumberPref } from '../../store/preferences';
import { useAppSelector } from '../../store';
import { useIntersection } from '../../hooks/useIntersection';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { togglePanelCollapsed, usePanelCollapsed } from '../../hooks/usePanelCollapse';
import { fetchNui } from '../../utils/fetchNui';
import InventoryFilters, { InventorySort, usePanelSortMode, usePrefsRevision } from './InventoryFilters';
import { BagIcon, GridIcon} from '../utils/icons';

const PAGE_SIZE = 30;

const EMPTY_FAVOURITES: readonly string[] = [];

const formatWeight = (weight: number): string => {
  if (weight >= 1000) return `${(weight / 1000).toFixed(1)}kg`;

  return `${Math.round(weight)}g`;
};

const getWeightColorClass = (percent: number): string => {
  if (percent >= 100) return 'weight-critical';
  if (percent >= 80) return 'weight-warning';

  return '';
};

interface InventoryGridProps {
  inventory: Inventory;
  slots?: Slot[];
  combinedWeight?: number;
}

const InventoryGrid: React.FC<InventoryGridProps> = ({ inventory, slots, combinedWeight }) => {
  const [page, setPage] = useState(0);
  const containerRef = useRef(null);
  const { ref, entry } = useIntersection({ threshold: 0.5 });
  const isBusy = useAppSelector((state) => state.inventory.isBusy);

  const prefsRevision = usePrefsRevision();

  const isPlayer = inventory.type === 'player';
  const renderedSlots = slots || inventory.items;
  const [sortMode, setSortMode] = usePanelSortMode();
  const favourites = getFavourites();

  const sortedSlots = useMemo(
    () => sortSlots(renderedSlots, sortMode, getPinFavourites() ? favourites : EMPTY_FAVOURITES),
    [renderedSlots, sortMode, favourites, prefsRevision]
  );

  const pageSize = Math.max(1, getNumberPref('pageSize') || PAGE_SIZE);

  const weight = useMemo(() => {
    if (combinedWeight !== undefined) return combinedWeight;

    return inventory.maxWeight !== undefined ? Math.floor(getTotalWeight(inventory.items) * 1000) / 1000 : 0;
  }, [inventory.maxWeight, inventory.items, combinedWeight]);

  const weightPercent = useMemo(
    () => (inventory.maxWeight ? (weight / inventory.maxWeight) * 100 : 0),
    [weight, inventory.maxWeight]
  );

  useEffect(() => {
    if (entry && entry.isIntersecting) {
      setPage((prev) => ++prev);
    }
  }, [entry]);

  const itemCount = useMemo(() => inventory.items.filter((item) => item.name).length, [inventory.items]);

  const isCollapsed = usePanelCollapsed(inventory.id);

  const fallbackTitle = isPlayer
    ? Locale.ui_inventory || 'Inventory'
    : inventory.type === InventoryType.BACKPACK
    ? Locale.ui_backpack || 'Backpack'
    : Locale.ui_other_inventory || 'Other Inventory';

  return (
    <div className={`inventory-panel${isCollapsed ? ' collapsed' : ''}`} style={{ pointerEvents: isBusy ? 'none' : 'auto' }}>
      <div className="inventory-panel-header">
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
          <div className={`panel-weight ${getWeightColorClass(weightPercent)}`}>
            <div className="panel-weight-text">
              <div className="panel-weight-label">{Locale.ui_weight || 'Weight'}</div>
              <div className="panel-weight-value">
                {formatWeight(weight)} / {formatWeight(inventory.maxWeight)}
              </div>
            </div>
            <CircularWeight percent={weightPercent} />
          </div>
        )}
      </div>

      <InventoryFilters sort={<InventorySort value={sortMode} onChange={setSortMode} />} />

      <div className="inventory-grid-wrapper">
        <div className="inventory-grid-container" ref={containerRef}>
          {sortedSlots.slice(0, (page + 1) * pageSize).map((item, index) => {
            const key = `${inventory.type}-${inventory.id}-${item.slot}`;
            const slot = (
              <InventorySlot
                key={key}
                item={item}
                ref={index === (page + 1) * pageSize - 1 ? ref : null}
                inventoryType={inventory.type}
                inventoryGroups={inventory.groups}
                inventoryId={inventory.id}
              />
            );

            if (!item.name || favourites.indexOf(item.name) === -1) return slot;

            return (
              <div key={key} className="inventory-slot-favourite">
                {slot}
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
};

export default InventoryGrid;
