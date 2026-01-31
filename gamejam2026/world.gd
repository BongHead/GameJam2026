extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var node = preload("res://Temp/example_node.tscn")
	for x in range(6):
		var n = node.instantiate()
		n.position = random_vector(300, 800)
		add_child(n)

func random_vector(min, max):
	var v = Vector2.LEFT.normalized()
	v = v.rotated(randf_range(0, 360))
	return v * randf_range(min, max)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
