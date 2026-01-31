extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass	
var speed = 10
var _is_pressed = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	position += input_direction * speed

	
func _input(mouse_event:InputEvent)->void:
	if mouse_event is InputEventMouseMotion and _is_pressed:
		global_position -= mouse_event.relative
	if mouse_event is InputEventMouseButton:
		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			_is_pressed = mouse_event.pressed
		#if mouse_event.button_index == MOUSE_BUTTON_WHEEL_UP:
		#	camera.zoom.x -= 0.25
		#if mouse_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		#	$Camera2D.zoom.x += 0.25

func _on_back_to_colony_pressed() -> void:
	position = Vector2(0, 0)
	
