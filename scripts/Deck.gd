class_name Deck

extends Node2D

var card_count := 10

func _draw_card() -> Node2D:
	if card_count > 0:
		card_count -= 1
		var card_scene = preload("res://Card.tscn")
		var card_instance = card_scene.instantiate()
		card_instance.global_position = global_position
		print("Card drawn. Remaining cards: ", card_count)
		return card_instance
	else:
		print("No cards left in the deck.")
		return null
