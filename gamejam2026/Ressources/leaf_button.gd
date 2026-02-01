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
	
	
		
func gather(num):
	
	var ant_capacity = AntsStats.Worker_Ant["CRY"]
	var total_taken = num * ant_capacity
	var time = 0
	if material_count < total_taken:
		time = MATERIAL_CONSTANT.MaterialGatherTime.VERY_LOW
	elif num < 2:
		time = MATERIAL_CONSTANT.MaterialGatherTime.VERY_LOW
	elif num < 5:
		time = MATERIAL_CONSTANT.MaterialGatherTime.LOW
	elif num < 10:
		time = MATERIAL_CONSTANT.MaterialGatherTime.MEDIUM
	
	await get_tree().create_timer(time).timeout
	
	material_count -= total_taken
	
	if material_count <= 0:
		queue_free()
	
		
		
		
	
	
	
	

	
