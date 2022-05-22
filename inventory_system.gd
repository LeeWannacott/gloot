tool
extends EditorPlugin

# TODO: Item sprites
# TODO: Basic UI elements


func _enter_tree():
    add_custom_type("ItemDefinitions", "Resource", preload("item_definitions.gd"), preload("images/icon_item_definitions.svg"));

    add_custom_type("InventoryItem", "Node", preload("inventory_item.gd"), preload("images/icon_item.svg"));
    add_custom_type("InventoryItemStackable", "InventoryItem", preload("inventory_item_stackable.gd"), preload("images/icon_item_stackable.svg"));
    add_custom_type("InventoryItemRect", "InventoryItem", preload("inventory_item_rect.gd"), preload("images/icon_item_rect.svg"));

    add_custom_type("Inventory", "Node", preload("inventory.gd"), preload("images/icon_inventory.svg"));
    add_custom_type("InventoryStacked", "Inventory", preload("inventory_stacked.gd"), preload("images/icon_inventory_stacked.svg"));
    add_custom_type("InventoryGrid", "Inventory", preload("inventory_grid.gd"), preload("images/icon_inventory_grid.svg"));

    add_custom_type("ItemSlot", "Node", preload("item_slot.gd"), preload("images/icon_item_slot.svg"));

    add_custom_type("CtrlInventory", "VBoxContainer", preload("ctrl_inventory.gd"), null);
    add_custom_type("CtrlInventoryStacked", "CtrlInventory", preload("ctrl_inventory_stacked.gd"), null);


func _exit_tree():
    remove_custom_type("ItemDefinitions");

    remove_custom_type("InventoryItem");
    remove_custom_type("InventoryItemStackable");
    remove_custom_type("InventoryItemRect");

    remove_custom_type("Inventory");
    remove_custom_type("InventoryStacked");
    remove_custom_type("InventoryGrid");

    remove_custom_type("ItemSlot");

    remove_custom_type("CtrlInventory");
    remove_custom_type("CtrlInventoryStacked");
