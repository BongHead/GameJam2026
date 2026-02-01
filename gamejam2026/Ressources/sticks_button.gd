extends Area2D

@onready var _pcon = $Background
@onready var material_count = MATERIAL_CONSTANT.MaterialCount.MEDIUM

func _on_button_pressed() -> void:
	var _antcount = get_parent().ants
	$Button/AudioStreamPlayer2D.play()
	print("stick pressed")
	_pcon.visible = not _pcon.visible
	
	$Background/VBoxContainer/HSlider_worker.max_value = _antcount
	$Background/VBoxContainer/HSlider_warrior.max_value = 0

func _on_gather_pressed() -> void:
	var num_workers = $Background/VBoxContainer/HSlider_worker.value
	var num_warriors = $Background/VBoxContainer/HSlider_warrior.value
	var location = position
	
	get_parent().send_ants(num_warriors, num_workers, location, self )
	_pcon.visible = not _pcon.visible

func gather(num_warrior, num_worker):
	var ant_cap_worker = AntsStats.Worker_Ant["CRY"]
	var ant_cap_warrior = AntsStats.Soldier_Ant["CRY"]
	var total_taken = num_warrior * ant_cap_warrior + num_worker * ant_cap_worker
	var total_ants = num_worker + num_warrior
	var time = 0
	if material_count < total_taken:
		time = MATERIAL_CONSTANT.MaterialGatherTime.VERY_LOW
	elif total_ants < 2:
		time = MATERIAL_CONSTANT.MaterialGatherTime.MEDIUM
	elif total_ants < 5:
		time = MATERIAL_CONSTANT.MaterialGatherTime.LOW
	elif total_ants < 10:
		time = MATERIAL_CONSTANT.MaterialGatherTime.VERY_LOW
		
	
	await get_tree().create_timer(time).timeout
	var completed = material_count
	material_count -= total_taken
	
	if material_count <= 0:
		
		queue_free()
		return [0, completed] 
	
	return [0, total_taken] # food, materials
