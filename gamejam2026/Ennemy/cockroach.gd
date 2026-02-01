extends Area2D

@onready var _pcon = $Background
@onready var enemy_hp = EnemyStats.HP.HIGH
@onready var enemy_atk = EnemyStats.ATK.LOW
@onready var enemy_dmg = EnemyStats.DMG.LOW
@onready var enemy_tgh = EnemyStats.TGH.HIGH
@onready var material_count = MATERIAL_CONSTANT.MaterialCount.HIGH


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	var _antcount = get_parent().ants
	$Button/AudioStreamPlayer2D.play()
	_pcon.visible = not _pcon.visible
	
	$Background/VBoxContainer/HSlider_worker.max_value = _antcount
	$Background/VBoxContainer/HSlider_warrior.max_value = 0
	get_parent().send_ants(num_warriors, num_workers, location, self )
	_pcon.visible = not _pcon.visible


func _on_gather_pressed() -> void:
	var num_workers = $Background/VBoxContainer/HSlider_worker.value
	var num_warriors = $Background/VBoxContainer/HSlider_warrior.value
	var location = position
	get_parent().send_ants(num, location)
	await get_tree().create_timer(5).timeout
	if get_parent().combat_calculation(num, num, enemy_hp, enemy_atk, enemy_numb, enemy_tgh, enemy_str):
		print("won combat")
		
		queue_free()
	else: 
		print("lost combat")
	
<<<<<<< HEAD
	get_parent().send_ants(num_warriors, num_workers, location, self )
	_pcon.visible = not _pcon.visible
	
=======
	_pcon.visible = false
	
	
>>>>>>> a099cdf5d9c7c737029901c79853eb56226a4a74
