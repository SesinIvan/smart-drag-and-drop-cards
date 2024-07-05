extends CardState


func _enter():
	card.color_rect.color = Color.DARK_ORCHID
	card.label.text = "HOVER"


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("mouse_left"):
		card.pivot_offset = card.get_global_mouse_position() - card.global_position
		transitioned.emit("Click")


func on_mouse_exited():
	transitioned.emit("Idle")
