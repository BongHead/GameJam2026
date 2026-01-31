extends RigidBody2D

const speed = 100

var destination = Vector2(100,100)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#	var distance_to_destination
#	var distance_to_move
#	if position != destination: # only move if we aren't there
#		distance_to_destination = position.distance_to(destination)
#		distance_to_move = speed * delta
#		if abs(distance_to_destination) < abs(distance_to_move): # if we are close, just move to destination
#			distance_to_move = distance_to_destination
#		position += position.direction_to(destination) * distance_to_move
