extends Area2D

@onready var _pcon = $Background
@onready var food_restore_value = FoodConstants.FoodRestoreValue.VERY_LOW
@onready var food_gather_time = FoodConstants.FoodGatherTime.VERY_LOW
@onready var food_spawn_number_on_start_up = FoodConstants.FoodSpawnRate.HIGH
@onready var material_count = MATERIAL_CONSTANT.MaterialCount.MEDIUM

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#print(FOOD_GATHER_TIME)
	#print(FOOD_RESTORE_VALUE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	var _antcount = get_parent().ants
	$Button/AudioStreamPlayer2D.play()
	print("fruit pressed")
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
		return [completed, 0] 
	
	return [total_taken, 0] # food, materials
