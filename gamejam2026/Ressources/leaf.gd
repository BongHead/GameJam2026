extends Area2D

enum PopupIds {
	GATHER,
	ATTACK,
}


@onready var _pm = $PopupMenu

func  _ready() -> void:
	_pm.add_item("Gather", PopupIds.GATHER)
	_pm.add_item("Attack", PopupIds.ATTACK)
	_pm.id_pressed.connect(_on_popup_menu_id_pressed)
	_pm.index_pressed.connect(_on_popup_menu_index_pressed)

#func _input(event: InputEvent) -> void:
#	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
#		_last_mouse_position = get_global_mouse_position()
#		_pm.popup(Rect2i(_last_mouse_position,_pm.size))


func _on_popup_menu_id_pressed(id: int) -> void:
	print_debug(id)

func _on_popup_menu_index_pressed(index: int) -> void:
	print_debug(index)


func _on_button_pressed() -> void:
	var _last_mouse_position = get_viewport().get_mouse_position()
	print(_last_mouse_position)
	_pm.popup(Rect2i(_last_mouse_position.x, _last_mouse_position.y, 100, 30))
