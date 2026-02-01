extends Area2D

@onready var _pcon = $Background
@onready var enemy_hp=EnemyStats.HP.LOW
@onready var enemy_atk =EnemyStats.ATK.LOW
@onready var enemy_def =EnemyStats.DEF.LOW
@onready var enemy_tgh =EnemyStats.TGH.LOW


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#print(FOOD_GATHER_TIME)
	#print(FOOD_RESTORE_VALUE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	_pcon.visible = not _pcon.visible
