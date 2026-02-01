extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.visible = false
	await get_tree().create_timer(2).timeout
	$RichTextLabel.text = "So hungry, they could eat a..."
	await get_tree().create_timer(2).timeout
	$Button.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$Sprite2D.visible = true
	$Button.visible = false
	$RichTextLabel.text = ""
	$AudioStreamPlayer.play()
	$AudioStreamPlayer2.play()
	await get_tree().create_timer(3).timeout
	$Sprite2D.visible = false
	$RichTextLabel.text = "+676 food!"
	await get_tree().create_timer(4).timeout
	get_parent().food_amount += 676
	get_parent().update_hud()
	queue_free()
