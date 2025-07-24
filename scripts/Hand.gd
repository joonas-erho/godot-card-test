class_name Hand

extends Node2D

var card_count := 3
var maximum_hand_size := 10

var cards_in_hand: Array[Draggable] = []
var hand_positions: Array[HandPosition] = []

func _ready():
	_calculate_hand_positions()

func _calculate_hand_positions():
	hand_positions.clear()
	var angle_step = 360.0 / maximum_hand_size
	for i in range(maximum_hand_size):
		var angle = deg_to_rad(i * angle_step)
		var pos = Vector2(cos(angle), sin(angle)) * 100  # Example radius
		var rot = angle
		hand_positions.append(HandPosition.new(pos, rot))
	
	for i in range(min(card_count, get_child_count(), hand_positions.size())):
		var child = get_child(i)
		child.position = hand_positions[i].position
		child.rotation = hand_positions[i].rotation
