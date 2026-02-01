extends Area2D

@onready var _pcon = $Background

func _on_button_pressed() -> void:
	var _antcount = get_parent().ants
	$Button/AudioStreamPlayer2D.play()
	_pcon.visible = not _pcon.visible
	
	$Background/VBoxContainer/HSlider_worker.max_value = _antcount
	$Background/VBoxContainer/HSlider_warrior.max_value = 0

func _on_gather_pressed() -> void:
	var num_workers = $Background/VBoxContainer/HSlider_worker.value
	var num_warriors = $Background/VBoxContainer/HSlider_warrior.value
	var location = position
	
	get_parent().send_ants(num_warriors, num_workers, location, self )
	_pcon.visible = not _pcon.visible
