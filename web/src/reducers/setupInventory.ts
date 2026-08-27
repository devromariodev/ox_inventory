import { CaseReducer, PayloadAction } from '@reduxjs/toolkit';
import { getItemData, itemDurability } from '../helpers';
import { Items } from '../store/items';
import { createEmptyInventory, Inventory, Slot, State } from '../typings';

/**
 * NewCity (#88, Fase 4 — P2): isto roda a CADA abertura de inventario e era
 * O(slots x itens): pra cada slot vazio, um `Object.values(...)` novo (aloca um
 * array com tudo dentro) e uma varredura ate achar o dono do slot. Num inventario
 * de 200 slots dava ~40 mil comparacoes e 200 arrays jogados fora, so pra desenhar
 * uma grade quase vazia.
 *
 * Agora e um indice slot -> item, montado UMA vez, e o preenchimento e O(n).
 * Mesma saida, mesma ordem.
 */
const densifyItems = (inventory: Inventory, curTime: number): Slot[] => {
  const bySlot = new Map<number, Slot>();

  for (const item of Object.values(inventory.items)) {
    if (item?.slot !== undefined) bySlot.set(item.slot, item);
  }

  return Array.from(Array(inventory.slots), (_, index) => {
    const item = bySlot.get(index + 1) || { slot: index + 1 };

    if (!item.name) return item;

    if (typeof Items[item.name] === 'undefined') {
      getItemData(item.name);
    }

    item.durability = itemDurability(item.metadata, curTime);
    return item;
  });
};

export const setupInventoryReducer: CaseReducer<
  State,
  PayloadAction<{
    leftInventory?: Inventory;
    rightInventory?: Inventory;
    backpackInventory?: Inventory;
    containerInventory?: Inventory;
  }>
> = (state, action) => {
  const { leftInventory, rightInventory, backpackInventory, containerInventory } = action.payload;
  const curTime = Math.floor(Date.now() / 1000);

  if (leftInventory)
    state.leftInventory = {
      ...leftInventory,
      items: densifyItems(leftInventory, curTime),
    };

  if (rightInventory)
    state.rightInventory = {
      ...rightInventory,
      items: densifyItems(rightInventory, curTime),
    };

  if (backpackInventory) {
    state.backpackInventory = {
      ...backpackInventory,
      items: densifyItems(backpackInventory, curTime),
    };
  } else if (state.backpackInventory.id !== '') {
    state.backpackInventory = createEmptyInventory();
  }

  if (containerInventory) {
    state.containerInventory = {
      ...containerInventory,
      items: densifyItems(containerInventory, curTime),
    };
  } else if (state.containerInventory.id !== '') {
    state.containerInventory = createEmptyInventory();
  }

  state.shiftPressed = false;
  state.isBusy = false;
};
