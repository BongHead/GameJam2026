extends Area2D

@onready var _pcon = $Background
@onready var material_count = MATERIAL_CONSTANT.MaterialCount.LOW



func _on_button_pressed() -> void:
	var _antcount = get_parent().ants
	$Button/AudioStreamPlayer2D.play()
	print("leaf pressed")
	print(material_count)
	_pcon.visible = not _pcon.visible
	
	$Background/VBoxContainer/HSlider_worker.max_value = _antcount
	$Background/VBoxContainer/HSlider_warrior.max_value = 0

func _on_gather_pressed() -> void:
	var num = $Background/VBoxContainer/HSlider_worker.value
	var location = position
	get_parent().send_ants(num, location)

func take_material(take_amount):
	if material_count - take_amount <= 0:
		_pcon.visible = not _pcon.visible
		return material_count - take_amount
	else:
		material_count -= take_amount
	
	return take_amount
