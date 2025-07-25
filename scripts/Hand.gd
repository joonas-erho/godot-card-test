class_name Hand

extends Node2D

var card_count := 3
var maximum_hand_size := 10

var cards_in_hand: Array[Card] = []
var hand_positions: Array[HandPosition] = []

func _ready():
	_calculate_hand_positions()

func _calculate_hand_positions():
	hand_positions.clear()
	for i in range(maximum_hand_size):
		var pos = Vector2(0, 0)
		hand_positions.append(HandPosition.new(pos, 0))
	
	for i in range(min(card_count, cards_in_hand.size(), hand_positions.size())):
		var card = cards_in_hand[i]
		print(hand_positions[i].position, hand_positions[i].rotation)
		"""
		card.card_node.global_position.x = hand_positions[i].position.x
		card.card_node.global_position.y = hand_positions[i].position.y
		"""
		card.card_node.global_rotation.z = hand_positions[i].rotation

func _add_card(card: Node2D):
	if cards_in_hand.size() < maximum_hand_size:
		cards_in_hand.append(card)
		add_child(card)

		_calculate_hand_positions()
	else:
		print("Cannot add more cards to hand, maximum size reached.")
