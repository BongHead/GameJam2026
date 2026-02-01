extends Area2D

const SPEED = 200
var destination = Vector2(0, 0)
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
		position += position.direction_to(destination) * distance_to_move

func set_destination(new_destination):
	destination = new_destination
