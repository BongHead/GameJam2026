extends VBoxContainer

@onready var slider_label = $slider_label
@onready var h_slider = $HSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slider_label.text = str(h_slider.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_h_slider_value_changed(value: float) -> void:
	slider_label.text = str(value)
