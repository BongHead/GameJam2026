extends VBoxContainer

@onready var slider_label_worker = $slider_label_worker
@onready var h_slider_worker = $HSlider_worker
@onready var slider_label_warrior = $slider_label_warrior
@onready var h_slider_warrior = $HSlider_warrior

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slider_label_worker.text = str(h_slider_worker.value)
	slider_label_warrior.text = str(h_slider_warrior.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_h_slider_value_changed(value: float) -> void:
	slider_label_worker.text = str(h_slider_worker.value)
	slider_label_warrior.text = str(h_slider_warrior.value)


func _on_button_pressed() -> void:
	pass # Replace with function body.
