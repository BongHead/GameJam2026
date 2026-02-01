extends Area2D

const SPEED = 200
var destination = Vector2(0, 0)
var storage_capacity = 3
var food = 0
var materials = 0
var number_of_warrior = 0
var number_of_worker = 0
var done_action = false
var back_home = false

@onready var target_material = $"./Ressources/"

var target
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	var distance_to_destination
	var distance_to_move
	if position != destination: # only move if we aren't there
		distance_to_destination = position.distance_to(destination)
		distance_to_move = SPEED * delta
		if abs(distance_to_destination) < abs(distance_to_move): # if we are close, just move to destination
			distance_to_move = distance_to_destination
			
		if position.direction_to(destination).x > 0:
			$AnimatedSprite2D.flip_h = true
		elif position.direction_to(destination).x <= 0:
			$AnimatedSprite2D.flip_h = false
		position += position.direction_to(destination) * distance_to_move
	elif not done_action:
		done_action = true
		var g = await target.gather(number_of_warrior, number_of_worker)
		food = g[0]
		materials = g[1]
		if food == 0 and materials == 0:
			queue_free()
		destination = Vector2.ZERO
		$Label.text = "food: %d\nmaterials: %d" % [food, materials]
		$AnimatedSprite2D.play("carry")
		$AudioStreamPlayer2D.play()
	elif destination == Vector2.ZERO and not back_home:
		back_home = true
		var parent = get_parent()
		$"../backhomesound".play()
		parent.food_amount += food
		parent.materials += materials
		parent.worker_ants += number_of_worker
		parent.soldier_ants += number_of_warrior
		parent.update_hud()
		queue_free()
	
		
func set_destination(new_destination):
	destination = new_destination
	
# func gather(gathered):
# 	if collected < storage_capacity:
# 		collected += gathered

func set_num(a, b):
	number_of_warrior = a
	number_of_worker = b
	$Label.text = "soldier: %d\nworker: %d" % [a, b]
	

func attack():
	pass
