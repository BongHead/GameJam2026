extends Node2D
var fruit_node = preload("res://Food/fruit.tscn")
var worms_eggs_node = preload("res://Food/worm_eggs.tscn")
var leaf_node = preload("res://Ressources/leaf.tscn")
var sticks_node = preload("res://Ressources/sticks.tscn")
var water_node = preload("res://Ressources/water.tscn")
var wisadel_node = preload("res://Ennemy/cockroach.tscn")
var ennemy_ant_node = preload("res://Ennemy/ennemy_ant_nest.tscn")
var hornet_node = preload("res://Ennemy/hornet_nest.tscn")
var Resources = [leaf_node, sticks_node, water_node]
var Enemies = [wisadel_node, ennemy_ant_node]
var food = [fruit_node, worms_eggs_node]
var common_set_up = [leaf_node, fruit_node]
var uncommon_set_up = [sticks_node, wisadel_node]
var rare_set_up = [water_node, ennemy_ant_node, hornet_node, worms_eggs_node]
var renewing_resource = [leaf_node, fruit_node, worms_eggs_node, wisadel_node]
var common = 9
var uncommon = 5
var rare = 2
var resource_regen_counter = 0
var ant = preload("res://Ant.tscn")
var active_ant = preload("res://ActiveAnt.tscn")

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

var worker_ants = 10
var soldier_ants = 0
var worker_generation = 1
var soldier_generation = 0
var total_generation = worker_generation + soldier_generation
var worker_upkeep = 1
var soldier_upkeep = 4
var upkeep_modifier = 1
var Hatcheries_Level = 0
var Farms_Level = 0
var Soldier_Hatch_Level = 0
var Formic_Level = 0
var Keratin_Level = 0
var Mandible_Level = 0

var ants
var max_ants
var next_ant
var food_amount
var next_food
var materials

func new_game():
	ants = worker_ants + soldier_ants
	max_ants = ants
	next_ant = ANT_INTERVAL
	food_amount = 200
	materials = 200
	next_food = FOOD_INTERVAL
	AntsStats.Worker_Ant["STR"] = 2
	AntsStats.Soldier_Ant["STR"] = 5
	AntsStats.Worker_Ant["TGH"] = 2
	AntsStats.Soldier_Ant["TGH"] = 4
	AntsStats.Soldier_Ant["DMG"] = 4

	update_hud()
	update_tech()

func _process(delta: float) -> void:
	var not_generate_resources = is_resources_enough()
	if (!not_generate_resources):
		var view_port_size = get_viewport_rect().size
		var v = randi_range(0, 3)
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
		if Hatcheries_Level == 3:
			worker_ants = round(1.05*worker_ants)+worker_generation
		ants += total_generation
		max_ants = max(ants,max_ants)
		update_hud()
	if next_food <= 0:
		next_food += FOOD_INTERVAL
		food_amount = max(food_amount-(worker_ants*worker_upkeep+soldier_ants*soldier_upkeep)*upkeep_modifier,0)
		if food_amount == 0:
			ants -= round(0.1*max_ants)
		update_hud()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		$Hud/base_menu_ui.visible = false

func update_hud():
	$Hud/HBoxContainer/VBoxContainer/Ants.text = "Ants: %d" % ants
	$Hud/HBoxContainer/VBoxContainer/Ants2.text = "+%d every %d seconds" % [total_generation,ANT_INTERVAL]
	$Hud/HBoxContainer/VBoxContainer2/Food.text = "Food: %d" % food_amount
	$Hud/HBoxContainer/VBoxContainer2/Food2.text = "-%d every %d seconds" % [ants, FOOD_INTERVAL]
	$Hud/HBoxContainer/Materials.text = "Materials: %d" % materials
	
func update_tech():
	$Hud/base_menu_ui/TechTree/HatchLevel.text = "%d/%d" % [Hatcheries_Level, TechTree.Hatcheries.max_level]
	$Hud/base_menu_ui/TechTree/FarmsLevel.text = "%d/%d" % [Farms_Level, TechTree.Farms.max_level]
	$Hud/base_menu_ui/TechTree/SoldierLevel.text = "%d/%d" % [Soldier_Hatch_Level, TechTree.Soldier_Hatcheries.max_level]
	$Hud/base_menu_ui/TechTree/FormicLevel.text = "%d/%d" % [Formic_Level, TechTree.Formic_concentration.max_level]
	$Hud/base_menu_ui/TechTree/KeratinLevel.text = "%d/%d" % [Keratin_Level, TechTree.Keratin_Reinforcement.max_level]
	$Hud/base_menu_ui/TechTree/MandibleLevel.text = "%d/%d" % [Mandible_Level, TechTree.Crushing_Mandibles.max_level]
	
func send_ants(num: int, location: Vector2) -> void:
	var instance = active_ant.instantiate()
	add_child(instance)
	instance.set_destination(location)

func upgrade_hatchery()->void:
		print("hit")
		if ants >= TechTree.Hatcheries.unlock:
			if materials >= TechTree.Hatcheries.material_cost && food_amount >= TechTree.Hatcheries.food_cost:
				if Hatcheries_Level < TechTree.Hatcheries.max_level:
					Hatcheries_Level += 1
					materials -= TechTree.Hatcheries.material_cost
					food_amount -= TechTree.Hatcheries.food_cost 
					match Hatcheries_Level:
						1: worker_generation = round(worker_generation*2)
						2: worker_generation = round(worker_generation*1.75)
				else:
					$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Technology Already at Maximum Level"
			else:
				$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Insufficient Food/Materials!"
		else:
			$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Insufficient Colony Size!"
		update_tech()
		update_hud()

func upgrade_farms()->void:
		print("farm")
		if ants >= TechTree.Farms.unlock:
			if materials >= TechTree.Farms.material_cost && food_amount >= TechTree.Farms.food_cost:
				if Farms_Level < TechTree.Farms.max_level:
					Farms_Level += 1
					materials -= TechTree.Farms.material_cost
					food_amount -= TechTree.Farms.food_cost
					match Farms_Level:
						1: upkeep_modifier = 0.95
						2: upkeep_modifier = 0.9
						3: upkeep_modifier = 0.85
				else:
					$Hud/base_menu_ui/TechTree/ErrorMessageMax.text = "Technology Already at Maximum Level"
			else:
				$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Insufficient Food/Materials!"
		else:
			$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Insufficient Colony Size!"
		update_tech()
		update_hud()
		
func upgrade_Soldier()->void:
		print("soldier")
		if ants >= TechTree.Soldier_Hatcheries.unlock:
			if materials >= TechTree.Soldier_Hatcheries.material_cost && food_amount >= TechTree.Soldier_Hatcheries.food_cost:
				if Soldier_Hatch_Level < TechTree.Soldier_Hatcheries.max_level:
					Soldier_Hatch_Level += 1
					materials -= TechTree.Soldier_Hatcheries.material_cost
					food_amount -= TechTree.Soldier_Hatcheries.food_cost
					match Soldier_Hatch_Level:
						1: soldier_generation = 1
						2: soldier_generation = 2
						3: soldier_generation = 5
				else:
					$Hud/base_menu_ui/TechTree/ErrorMessageMax.text = "Technology Already at Maximum Level"
			else:
				$Hud/base_menu_ui/TechTree/ErrorMessageR.text = "Insufficient Food/Materials!"
		else:
			$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Insufficient Colony Size!"
		update_tech()
		update_hud()
		
func upgrade_Formic()->void:
		print("Formic")
		if ants >= TechTree.Formic_concentration.unlock:
			if materials >= TechTree.Formic_concentration.material_cost && food_amount >= TechTree.Formic_concentration.food_cost:
				if Formic_Level < TechTree.Formic_concentration.max_level:
					Formic_Level += 1
					materials -=TechTree.Formic_concentration.material_cost
					food_amount -=TechTree.Formic_concentration.food_cost
					AntsStats.Worker_Ant["STR"] +=1
					AntsStats.Soldier_Ant["STR"] +=1
				else:
					$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Technology Already at Maximum Level"
			else:
				$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Insufficient Food/Materials!"
		else:
			$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Insufficient Colony Size!"
		update_tech()
		update_hud()
		
func upgrade_Keratin()->void:
		print("Keratin")
		if ants >= TechTree.Keratin_Reinforcement.unlock:
			if materials >= TechTree.Keratin_Reinforcement.material_cost && food_amount >= TechTree.Keratin_Reinforcement.food_cost:
				if Keratin_Level < TechTree.Keratin_Reinforcement.max_level:
					Keratin_Level += 1
					materials -=TechTree.Keratin_Reinforcement.material_cost
					food_amount -=TechTree.Keratin_Reinforcement.food_cost
					AntsStats.Worker_Ant["TGH"] += 1
					AntsStats.Soldier_Ant["TGH"] +=1
				else:
					$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Technology Already at Maximum Level"
			else:
				$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Insufficient Food/Materials!"
		else:
			$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Insufficient Colony Size!"
		update_tech()
		update_hud()
		
func upgrade_Mandibles()->void:
		print("Mandibles")
		if ants >= TechTree.Crushing_Mandibles.unlock:
			if materials >= TechTree.Crushing_Mandibles.material_cost && food_amount >= TechTree.Crushing_Mandibles.food_cost:
				if Mandible_Level < TechTree.Crushing_Mandibles.max_level:
					Mandible_Level += 1
					materials -= TechTree.Crushing_Mandibles.material_cost
					food_amount -= TechTree.Crushing_Mandibles.food_cost
					AntsStats.Soldier_Ant["DMG"] +=1
				else:
					$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Technology Already at Maximum Level"
			else:
				$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Insufficient Food/Materials!"
		else:
			$Hud/base_menu_ui/TechTree/ErrorMessage.text = "Insufficient Colony Size!"
		update_tech()
		update_hud()
