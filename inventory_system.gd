tool
extends EditorPlugin

# TODO: Item description files
# TODO: Item sprites
# TODO: Basic UI elements


func _enter_tree():
    add_autoload_singleton("ItemDefinitions", "res://addons/inventory_system/item_definitions.gd");

    add_custom_type("InventoryItem", "Node", preload("inventory_item.gd"), preload("images/icon_item.svg"));
    add_custom_type("InventoryItemStackable", "Node", preload("inventory_item_stackable.gd"), preload("images/icon_item_stackable.svg"));
    add_custom_type("InventoryItemWeight", "Node", preload("inventory_item_weight.gd"), preload("images/icon_item_weight.svg"));
    add_custom_type("InventoryItemRect", "Node", preload("inventory_item_rect.gd"), preload("images/icon_item_rect.svg"));

    add_custom_type("Inventory", "Node", preload("inventory.gd"), preload("images/icon_inventory.svg"));
    add_custom_type("InventoryLimited", "Node", preload("inventory_limited.gd"), preload("images/icon_inventory_limited.svg"));
    add_custom_type("InventoryGrid", "Node", preload("inventory_grid.gd"), preload("images/icon_inventory_grid.svg"));

    add_custom_type("ItemSlot", "Node", preload("item_slot.gd"), preload("images/icon_item_slot.svg"));


func _exit_tree():
    remove_autoload_singleton("ItemDefinitions");

    remove_custom_type("InventoryItem");
    remove_custom_type("InventoryItemStackable");
    remove_custom_type("InventoryItemWeight");
    remove_custom_type("InventoryItemRect");

    remove_custom_type("Inventory");
    remove_custom_type("InventoryLimited");
    remove_custom_type("InventoryGrid");

    remove_custom_type("ItemSlot");
