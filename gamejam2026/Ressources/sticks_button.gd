extends Area2D

@onready var _pcon = $Background

func _on_button_pressed() -> void:
	_pcon.visible = not _pcon.visible
	
