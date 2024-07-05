extends CardState


func _enter():
	card.color_rect.color = Color.BLUE
	card.label.text = "DRAG"
	
	card.index = card.get_index()
	
	var canvas_layer := get_tree().get_first_node_in_group("fields")
	if canvas_layer:
		card.reparent(canvas_layer)


func on_input(event: InputEvent):
	var mouse_motion := event is InputEventMouseMotion
	var confirm = event.is_action_released("mouse_left")
	
	if mouse_motion:
		card.global_position = card.get_global_mouse_position() - card.pivot_offset
	
	if confirm:
		get_viewport().set_input_as_handled()
		transitioned.emit("Release")
