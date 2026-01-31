extends RigidBody2D

var idle = true
var next_flip = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	next_flip -= delta
	if next_flip <= 0:
		linear_velocity.x = - linear_velocity.x

		if global_position.distance_to(Vector2.ZERO) > 250:
			linear_velocity = global_position.direction_to(Vector2.ZERO) * 150
		if randf() < 0.2:
			linear_velocity.x = randf_range(-200, 200)
			linear_velocity.y = randf_range(-60, 60)

		$AnimatedSprite2D.flip_h = linear_velocity.x > 0

		next_flip = randf_range(0.2, 1.3)
