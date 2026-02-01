extends Area2D

@onready var _pcon = $Background


func _on_button_pressed() -> void:
	var _antcount = get_parent().ants
	$Button/AudioStreamPlayer2D.play()
	print("leaf pressed")
	_pcon.visible = not _pcon.visible
	
	$Background/VBoxContainer/HSlider_worker.max_value = _antcount
	$Background/VBoxContainer/HSlider_warrior.max_value = 0

func _on_gather_pressed() -> void:
	var num = $Background/VBoxContainer/HSlider_worker.value
	var location = position
	get_parent().send_ants(num, location)
