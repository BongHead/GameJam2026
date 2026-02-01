extends Area2D

@onready var _pcon = $Background
@onready var enemy_hp=EnemyStats.HP.LOW
@onready var enemy_atk =EnemyStats.ATK.HIGH
@onready var enemy_def =EnemyStats.DEF.MEDIUM
@onready var enemy_tgh =EnemyStats.TGH.LOW


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

func _on_gather_pressed() -> void:
	var num = $Background/VBoxContainer/HSlider_worker.value
	var location = position
	get_parent().send_ants(num, location)
