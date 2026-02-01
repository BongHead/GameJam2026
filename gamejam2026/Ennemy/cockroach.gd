extends Area2D

@onready var _pcon = $Background
@onready var enemy_hp=EnemyStats.HP.HIGH
@onready var enemy_atk =EnemyStats.ATK.LOW
@onready var enemy_def =EnemyStats.DEF.MEDIUM
@onready var enemy_tgh =EnemyStats.TGH.MEDIUM




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	$Button/AudioStreamPlayer2D.play()
	_pcon.visible = not _pcon.visible
