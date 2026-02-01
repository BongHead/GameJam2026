extends Area2D

@onready var _pcon = $Background

func _on_button_pressed() -> void:
	$Button/AudioStreamPlayer2D.play()
	print("stick pressed")
	_pcon.visible = not _pcon.visible
	
