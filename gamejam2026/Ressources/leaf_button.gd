extends Area2D

@onready var _pcon = $Background
@onready var material_count = MATERIAL_CONSTANT.MaterialCount.LOW



func _on_button_pressed() -> void:
	var _worker_antcount = get_parent().worker_ants
	var _warrior_antcount = get_parent().soldier_ants
	$Button/AudioStreamPlayer2D.play()
	print("leaf pressed")
	print(material_count)
	_pcon.visible = not _pcon.visible
	
	$Background/VBoxContainer/HSlider_worker.max_value = _worker_antcount
	$Background/VBoxContainer/HSlider_warrior.max_value = _warrior_antcount

func _on_gather_pressed() -> void:
	var num_workers = $Background/VBoxContainer/HSlider_worker.value
	var num_warriors = $Background/VBoxContainer/HSlider_warrior.value
	var location = position
	
	get_parent().send_ants(num_warriors, num_workers, location, self )
	_pcon.visible = not _pcon.visible
	
@onready var gather_flag = true
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
	
	material_count -= total_taken
	
	if material_count <= 0:
		queue_free()
	
		
	_pcon.visible = false

func take_material(take_amount):
	if material_count - take_amount <= 0:
		_pcon.visible = not _pcon.visible
		return material_count - take_amount
	else:
		material_count -= take_amount
	
	return take_amount
