extends Area2D

const SPEED = 200
var destination = Vector2(0, 0)
var storage_capacity = 3
var collected = 0
var number_of_ants = 0

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
	else:
		for group in get_groups():
			if not str(group).begins_with("_"):
				print(group)
				get_tree().call_group(group, "queue_free")
		target.gather(number_of_ants)
	
		
func set_destination(new_destination):
	destination = new_destination
	
func gather(gathered):
	if collected < storage_capacity:
		collected += gathered

func set_num(num):
	number_of_ants = num
	$Label.text = str(num)
	

func attack():
	pass
