extends CardState


func _enter():
	card.color_rect.color = Color.ORANGE
	card.label.text = "CLICKED"


func on_input(event):
	if event is InputEventMouseMotion:
		transitioned.emit("Drag")
