extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var node = preload("res://Temp/example_node.tscn")
	for x in range(6):
		var n = node.instantiate()
		var position = random_vector(300, 800)
		while (not is_valid_position(position)):
			position = random_vector(300, 800)
		n.position = position
		n.add_to_group("resources")
		add_child(n)

func is_valid_position(pos: Vector2):
	for enemy in get_tree().get_nodes_in_group("resources"):
		if enemy.global_position.distance_to(pos) < 200:
			return false
	return true

func random_vector(min, max):
	var v = Vector2.LEFT.normalized()
	v = v.rotated(randf_range(0, 360))
	v = v * randf_range(min, max)
	return v

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
