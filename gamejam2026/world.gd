extends Node2D
var fruit_node = preload("res://Food/fruit.tscn")
var insect_node = preload("res://Food/insect.tscn")
var worms_eggs_node = preload("res://Food/worm_eggs.tscn")
var leaf_node = preload("res://Ressources/leaf.tscn")
var sticks_node = preload("res://Ressources/sticks.tscn")
var water_node = preload("res://Ressources/water.tscn")
var butterfly_node = preload("res://Ennemy/butterfly.tscn")
var wisadel_node = preload("res://Ennemy/cockroach.tscn")
var ennemy_ant_node = preload("res://Ennemy/ennemy_ant_nest.tscn")
var hornet_node = preload("res://Ennemy/hornet_nest.tscn")
var Resources = [leaf_node, sticks_node, water_node]
var Enemies = [butterfly_node, wisadel_node, ennemy_ant_node]
var food = [fruit_node, insect_node, worms_eggs_node]
var common_set_up = [leaf_node, butterfly_node, fruit_node]
var uncommon_set_up = [sticks_node, wisadel_node, insect_node]
var rare_set_up = [water_node, ennemy_ant_node, hornet_node, worms_eggs_node]
var renewing_resource = [leaf_node, fruit_node, insect_node, worms_eggs_node, wisadel_node]
var common = 9
var uncommon = 5
var rare = 2
var resource_regen_counter = 0
var ant = preload("res://Ant.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

	for thing in common_set_up:
		for x in range(common):
			place_resources_on_map(1589, 3457, thing)
	for thing in uncommon_set_up:
		for x in range(uncommon):
			place_resources_on_map(5908, 4678, thing)
	for thing in rare_set_up:
		#if thing == hornet_node:
		for x in range(rare):
			place_resources_on_map(8000, 5689, thing)
	for x in range(11):
		place_resources_on_map(0, 200, ant, true)
	
	#lets think about this, let generate a fix amount of 
	#resources of the same tier at the beguinning, so i must tier
	#the food? then need to make a list ?
	
func place_resources_on_map(x_zone: int, y_zone: int, item: Resource, ignore_overlap: bool = false) -> void:
	var to_be_placed = item.instantiate()
	var be_placed_at = get_random_vector(x_zone, y_zone)
	while (not is_valid_position(be_placed_at) and not ignore_overlap):
		be_placed_at = get_random_vector(x_zone, y_zone)
	to_be_placed.position = be_placed_at
	to_be_placed.add_to_group("existing_resources")
	add_child(to_be_placed)
func place_ant_on_map(x_zone: int, y_zone: int, item: Resource, ignore_overlap: bool = false) -> void:
	var to_be_placed = item.instantiate()
	var be_placed_at = get_random_vector(x_zone, y_zone)
	while (not is_valid_position(be_placed_at) and not ignore_overlap):
		be_placed_at = get_random_vector(x_zone, y_zone)
	to_be_placed.position = be_placed_at
	add_child(to_be_placed)

func is_resources_enough() -> bool:
	var tree_of_resources = get_tree().get_nodes_in_group("existing_resources")
	var group_length = tree_of_resources.size()
	if group_length < 50:
		return false
	return true

func is_valid_position(pos: Vector2) -> bool:
	for x in get_tree().get_nodes_in_group("existing_resources"):
		if x.global_position.distance_to(pos) < 275:
			return false
	return true

func get_random_vector(min, max) -> Vector2:
	var v = Vector2.LEFT.normalized()
	v = v.rotated(randf_range(0, 360))
	v = v * randf_range(min, max)
	return v

var ANT_INTERVAL = 20
var FOOD_INTERVAL = 30

var ants
var next_ant
var food_amount
var next_food
var materials

func new_game():
	ants = 10
	next_ant = ANT_INTERVAL
	food_amount = 20
	materials = 0
	next_food = FOOD_INTERVAL
	update_hud()

func _process(delta: float) -> void:
	var not_generate_resources = is_resources_enough()
	if (!not_generate_resources):
		var view_port_size = get_viewport_rect().size
		var v = randi_range(0, 4)
		place_resources_on_map(int(view_port_size.x) + 500, int(view_port_size.y) + 500, renewing_resource[v])
		resource_regen_counter += 1
		print(resource_regen_counter)
		if resource_regen_counter > 15:
			place_resources_on_map(int(view_port_size.x) + 1000, int(view_port_size.y) + 1000, hornet_node)
			resource_regen_counter = 0
		
		
	next_ant -= delta
	next_food -= delta
	if next_ant <= 0:
		next_ant += ANT_INTERVAL
		ants += 1
		update_hud()
	if next_food <= 0:
		next_food += FOOD_INTERVAL
		food_amount -= ants
		update_hud()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		$Hud/base_menu_ui.visible = false

func update_hud():
	$Hud/HBoxContainer/VBoxContainer/Ants.text = "Ants: %d" % ants
	$Hud/HBoxContainer/VBoxContainer/Ants2.text = "+1 every %d seconds" % ANT_INTERVAL
	$Hud/HBoxContainer/VBoxContainer2/Food.text = "Food: %d" % food_amount
	$Hud/HBoxContainer/VBoxContainer2/Food2.text = "-%d every %d seconds" % [ants, FOOD_INTERVAL]
	$Hud/HBoxContainer/Materials.text = "Materials: %d" % materials
