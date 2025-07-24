class_name Card

extends Node

var currently_holding := false
@export var can_be_dragged := true

@export var card_node: CardNode

func _ready():
	pass
	"""
	var flip_timer = Timer.new()
	flip_timer.wait_time = 2.0
	flip_timer.autostart = true
	flip_timer.one_shot = false
	add_child(flip_timer)
	flip_timer.timeout.connect(_flip)
	"""

func _allow_dragging():
	can_be_dragged = true

func _flip():
	if card_node:
		can_be_dragged = false
		await card_node._flip()
