extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fruit_node = preload("res://Food/fruit.tscn")
	var insect_node= preload("res://Food/insect.tscn")
	var worms_eggs_node=preload("res://Food/worm_eggs.tscn")
	var leaf_node = preload("res://Ressources/leaf.tscn")
	var sticks_node= preload("res://Ressources/sticks.tscn")
	var water_node=preload("res://Ressources/water.tscn")
	var butterfly_node= preload("res://Ennemy/butterfly.tscn")
	var wisadel_node=preload("res://Ennemy/cockroach_nest.tscn")
	var hornet_node= preload("res://Ennemy/hornet_nest.tscn")
	var Resources=[leaf_node,sticks_node,water_node]
	var Enemies=[butterfly_node,wisadel_node,hornet_node]
	var food =[fruit_node,insect_node,worms_eggs_node]
	for thing in food:
		for x in range(5):
			place_resources_on_map(300,300,thing)
	
	#lets think about this, let generate a fix amount of 
	#resources of the same tier at the beguinning, so i must tier
	#the food? then need to make a list ?
	
func place_resources_on_map(x_zone:int,y_zone:int,item:Resource)-> void:
	var to_be_placed = item.instantiate()
	var be_placed_at = get_random_vector(x_zone,y_zone)
	while (not is_valid_position(be_placed_at)):
		be_placed_at = get_random_vector(x_zone,y_zone)
	to_be_placed.position=be_placed_at
	to_be_placed.add_to_group("existing_resources")
	add_child(to_be_placed)

func is_valid_position(pos: Vector2)->bool:
	for x in get_tree().get_nodes_in_group("existing_resources"):
		if x.global_position.distance_to(pos) < 15:
			return false
	return true

func get_random_vector(min, max)->Vector2:
	var v = Vector2.LEFT.normalized()
	v = v.rotated(randf_range(0, 360))
	v = v * randf_range(min, max)
	return v

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("test")	
