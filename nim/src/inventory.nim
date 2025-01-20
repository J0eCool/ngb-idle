import gdext
import gdext/classes/[
  gdControl,
]

type
  # The slot in which the items go
  ItemSlot = enum
    isHead
    isChest
    isLegs
    isBoots
    isGloves
    isWeapon
    isAccessory

  # ItemDef: static data for an item, shared across multiple specific item instances
  ItemDef = object
    slot: ItemSlot
    name: string
    stats: ItemStats

  Item = object
    def: ItemDef
    level: int
    boosts: ItemStats

  ItemStats = object
    power: int
    toughness: int
    bonuses: seq[ItemBonus]

  ItemBonus = object
    name: string

  Inventory* = ptr object of Control
