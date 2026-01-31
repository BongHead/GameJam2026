extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#func _click_on_main_hive(viewport:Node,event:InputEvent,shape_idx:int) -> void:
	#pass
#func _input(Input:InputEvent)-> void:
	#if Input is InputEventMouseButton and Input.is_pressed():
		#if Input.button_index == MOUSE_BUTTON_LEFT:
			#print("test")
			
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_RIGHT:
			pass
