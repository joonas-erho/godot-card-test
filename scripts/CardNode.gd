class_name CardNode

extends Node

signal allow_dragging

@export var front_texture: Texture2D
@export var back_texture: Texture2D

@export var card_node: Node3D
@export var sprite: Sprite3D

@export var flip_speed: float = 0.1

func _ready():
	sprite.texture = front_texture

func _flip():
	var tween = create_tween()
	tween.tween_property(card_node,
		"rotation_degrees:y", card_node.rotation_degrees.y + 90, flip_speed)
	await tween.finished

	if sprite.texture == front_texture:
		sprite.texture = back_texture
	else:
		sprite.texture = front_texture

	tween = create_tween()
	tween.tween_property(card_node,
		"rotation_degrees:y", card_node.rotation_degrees.y + 90, flip_speed)
	await tween.finished
	print("Card flipped")
	emit_signal("allow_dragging")
