@tool
extends Button

const EditorIcons = preload("res://addons/gloot/editor/common/editor_icons.gd")

@onready var window_dialog: Window = $"%Window"
@onready var protoset_editor: Control = $"%ProtosetEditor"

var protoset: ItemProtoset :
    get:
        return protoset
    set(new_protoset):
        protoset = new_protoset
        if protoset_editor:
            protoset_editor.protoset = protoset
var editor_interface: EditorInterface :
    get:
        return editor_interface
    set(new_editor_interface):
        editor_interface = new_editor_interface
        if protoset_editor:
            protoset_editor.editor_interface = editor_interface


func init(protoset_: ItemProtoset, editor_interface_: EditorInterface) -> void:
    protoset = protoset_
    editor_interface = editor_interface_


func _ready() -> void:
    icon = EditorIcons.get_icon(editor_interface, "Edit")
    window_dialog.close_requested.connect(func(): protoset.notify_property_list_changed())
    protoset_editor.protoset = protoset
    protoset_editor.editor_interface = editor_interface
    pressed.connect(func(): window_dialog.popup_centered(window_dialog.size))

