extends Area2D

@onready var food_restore_value = FoodConstants.FoodRestoreValue.MEDIUM
@onready var food_gather_time = FoodConstants.FoodGatherTime.MEDIUM
@onready var food_spawn_number_on_start_up = FoodConstants.FoodSpawnRate.LOW

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#print(FOOD_GATHER_TIME)
	#print(FOOD_RESTORE_VALUE)
func _get_start_up_number()-> int:
	return food_spawn_number_on_start_up


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
