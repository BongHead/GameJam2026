extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass	
var speed = 1200
var _is_pressed = false
var edge_margin = 50
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		var viewport = get_viewport()
		var mouse_pos = viewport.get_mouse_position()
		var screen_rect = viewport.get_visible_rect()
		var direction = Vector2(0,0)
	
		if mouse_pos.x < edge_margin:
			direction.x = -1
		elif mouse_pos.x > screen_rect.size.x - edge_margin:
			direction.x = 1
		
		if mouse_pos.y < edge_margin:
			direction.y = -1
		elif mouse_pos.y > screen_rect.size.y - edge_margin:
			direction.y = 1
	
		direction += Input.get_vector("left", "right", "up", "down")
		position += direction * speed * delta

	
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
	
