extends Area2D

@onready var food_restore_value = FoodConstants.FoodRestoreValue.VERY_LOW
@onready var food_gather_time = FoodConstants.FoodGatherTime.VERY_LOW
@onready var food_spawn_number_on_start_up = FoodConstants.FoodSpawnRate.HIGH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#print(FOOD_GATHER_TIME)
	#print(FOOD_RESTORE_VALUE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
