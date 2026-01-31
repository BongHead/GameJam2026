extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

var speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	position += input_direction * speed


func _on_back_to_colony_pressed() -> void:
	position = Vector2(0, 0)
