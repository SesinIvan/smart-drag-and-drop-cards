extends CardState


func _enter():
	card.color_rect.color = Color.WEB_GREEN
	card.label.text = "Idle"
	card.pivot_offset = Vector2.ZERO


func on_mouse_entered():
	transitioned.emit("hover")
