@tool
@icon("res://addons/gloot/images/icon_item_slot.svg")
class_name ItemRefSlot
extends "res://addons/gloot/core/item_slot_base.gd"

const Verify = preload("res://addons/gloot/core/verify.gd")
const KEY_ITEM_INDEX: String = "item_index"

@export var inventory_path: NodePath :
    get:
        return inventory_path
    set(new_inv_path):
        if inventory_path == new_inv_path:
            return
        inventory_path = new_inv_path
        update_configuration_warnings()
        _set_inventory_from_path(inventory_path)

var _wr_item: WeakRef = weakref(null)
var _wr_inventory: WeakRef = weakref(null)
var inventory: Inventory = null :
    get = _get_inventory, set = _set_inventory


func _ready() -> void:
    _set_inventory_from_path(inventory_path)


func _set_inventory_from_path(path: NodePath) -> bool:
    if path.is_empty():
        return false

    var node: Node = null

    if is_inside_tree():
        node = get_node_or_null(inventory_path)

    if node == null || !(node is Inventory):
        return false
    
    clear()
    _set_inventory(node)
    return true


func _set_inventory(inventory: Inventory) -> void:
    if inventory == _wr_inventory.get_ref():
        return

    if _get_inventory() != null:
        _disconnect_inventory_signals()

    clear()
    _wr_inventory = weakref(inventory)

    if _get_inventory() != null:
        _connect_inventory_signals()


func _connect_inventory_signals() -> void:
    if _get_inventory() == null:
        return

    if !_get_inventory().item_removed.is_connected(_on_item_removed):
        _get_inventory().item_removed.connect(_on_item_removed)


func _disconnect_inventory_signals() -> void:
    if _get_inventory() == null:
        return

    if _get_inventory().item_removed.is_connected(_on_item_removed):
        _get_inventory().item_removed.disconnect(_on_item_removed)


func _on_item_removed(item: InventoryItem) -> void:
    clear()


func _get_inventory() -> Inventory:
    return _wr_inventory.get_ref()


func equip(item: InventoryItem) -> bool:
    if !can_hold_item(item):
        return false

    if _wr_item.get_ref() == item:
        return false

    if get_item() != null && !clear():
        return false

    _wr_item = weakref(item)
    item_equipped.emit()
    return true


func clear() -> bool:
    if get_item() == null:
        return false
        
    _wr_item = weakref(null)
    cleared.emit()
    return true


func get_item() -> InventoryItem:
    return _wr_item.get_ref()


func can_hold_item(item: InventoryItem) -> bool:
    if item == null:
        return false

    if _get_inventory() == null || !_get_inventory().has_item(item):
        return false

    return true


func reset() -> void:
    clear()


func serialize() -> Dictionary:
    var result: Dictionary = {}
    var item : InventoryItem = _wr_item.get_ref()

    if item != null && item.get_inventory() != null:
        result[KEY_ITEM_INDEX] = item.get_inventory().get_item_index(item)

    return result


func deserialize(source: Dictionary) -> bool:
    if !Verify.dict(source, false, KEY_ITEM_INDEX, [TYPE_INT, TYPE_FLOAT]):
        return false

    reset()

    if source.has(KEY_ITEM_INDEX):
        var item_index: int = source[KEY_ITEM_INDEX]
        if !_equip_item_with_index(item_index):
            return false

    return true


func _equip_item_with_index(item_index: int) -> bool:
    if _get_inventory() == null:
        return false
    if item_index >= _get_inventory().get_item_count():
        return false
    equip(_get_inventory().get_items()[item_index])
    return true

