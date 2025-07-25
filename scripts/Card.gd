class_name Card

extends Node

var currently_holding := false
@export var can_be_dragged := true

@export var card_node: CardNode

func _allow_dragging():
	can_be_dragged = true

func _flip():
	if card_node:
		can_be_dragged = false
		await card_node._flip()
