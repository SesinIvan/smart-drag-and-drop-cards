extends CardState


func _enter():
	card.color_rect.color = Color.DARK_VIOLET
	card.label.text = "Release"

	#When a card is released, it checks where it is at the time of release.
	var field_areas = card.drop_point_detector.get_overlapping_areas()

	if field_areas.is_empty():
		card.home_field.return_card_starting_position(card)
	elif field_areas[0].get_parent() == card.home_field:
		card.home_field.card_reposition(card)
	else:
		var new_field: Field = field_areas[0].get_parent()
		new_field.set_new_card(card)

	transitioned.emit("idle")
