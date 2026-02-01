extends Area2D

@onready var _pcon = $Background
@onready var enemy_hp = EnemyStats.HP.LOW
@onready var enemy_atk = EnemyStats.ATK.HIGH
@onready var enemy_dmg = EnemyStats.DMG.MEDIUM
@onready var enemy_tgh = EnemyStats.TGH.LOW
@onready var enemy_str = EnemyStats.STR.HIGHT
@onready var enemy_num = 50
@onready var food_count = enemy_hp * enemy_num

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	var worker_ants_count = get_parent().worker_ants
	var soldier_ants_count = get_parent().soldier_ants
	$Button/AudioStreamPlayer2D.play()
	_pcon.visible = not _pcon.visible
	
	$Background/VBoxContainer/HSlider_worker.max_value = worker_ants_count
	$Background/VBoxContainer/HSlider_warrior.max_value = soldier_ants_count

func _on_gather_pressed() -> void:
	var worker_count = $Background/VBoxContainer/HSlider_worker.value
	var soldier_count = $Background/VBoxContainer/HSlider_warrior.value
	var location = position
	get_parent().send_ants(soldier_count, worker_count, location, self )
	get_parent().boss_music(true)
	#await get_tree().create_timer(5).timeout
	
	_pcon.visible = false
func gather(num_warrior, num_worker):
	if not await get_parent().combat_calculation(num_worker, num_warrior, enemy_hp, enemy_atk, enemy_num, enemy_tgh, enemy_str):
		get_parent().boss_music(false)
		return [0, 0]

	var food_count = enemy_hp * enemy_num
	var ant_cap_worker = AntsStats.Worker_Ant["CRY"]
	var ant_cap_warrior = AntsStats.Soldier_Ant["CRY"]
	var total_taken = num_warrior * ant_cap_warrior + num_worker * ant_cap_worker
	var total_ants = num_worker + num_warrior
	var time = 0
	if food_count < total_taken:
		time = FoodConstants.FoodGatherTime.VERY_LOW
	elif total_ants < 2:
		time = FoodConstants.FoodGatherTime.MEDIUM
	elif total_ants < 5:
		time = FoodConstants.FoodGatherTime.LOW
	elif total_ants < 10:
		time = FoodConstants.FoodGatherTime.VERY_LOW
		
	
	await get_tree().create_timer(time).timeout
	get_parent().boss_music(false)
	
	food_count -= total_taken
	
	if food_count <= 0:
		queue_free()
	
	return [total_taken, 0] # food, materials
