extends Node

@export var hand: Hand
@export var deck: Deck

func _ready():
	for i in range(0, 5):
		pass
		# _draw_card()

func _draw_card():
	var card = deck._draw_card()
	if card == null:
		print("No cards left in the deck.")
		return

	print(card.global_position)
	hand._add_card(card)


func _on_button_pressed() -> void:
	_draw_card()
