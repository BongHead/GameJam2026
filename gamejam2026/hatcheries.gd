extends Button

var parent
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	var node2d = $"../../../../../Node2D2"
	node2d.upgrade_hatchery()
	
