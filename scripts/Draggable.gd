class_name Draggable

extends Node2D

var currently_holding := false
var drag_offset := Vector2.ZERO
var velocity := Vector2.ZERO
var sprite: Sprite2D
var target_position := global_position

@export var smooth_speed := 5000.0
@export var max_tilt_angle := 20.0
@export var min_velocity_for_tilt := 500
@export var tilt_strength := 0.008

@export var parent: Card
@export var camera_node: Camera3D
@export var card_node: Node3D

static var card_instance_count := 0

func _ready():
	sprite = get_node("Sprite2D")
	target_position = global_position

	# Move camera and card so they are not overlayed in subviewport
	card_instance_count += 1
	var new_pos = card_instance_count * 10
	camera_node.global_position.x = new_pos
	camera_node.global_position.y = new_pos
	card_node.global_position.x = new_pos
	card_node.global_position.y = new_pos

func _unhandled_input(event):
	print(parent.can_be_dragged)
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed && parent.can_be_dragged:
			if get_global_rect().has_point(get_global_mouse_position()):
				currently_holding = true
				get_viewport().set_input_as_handled()
				card_node.rotation_degrees.z = 0
				z_index = 25
		else:
			currently_holding = false
			z_index = 0

func _process(delta):
	if currently_holding:
		target_position = get_global_mouse_position()

	var prev_position = global_position
	global_position = global_position.move_toward(target_position, smooth_speed * delta)
	velocity = (global_position - prev_position) / delta

	if card_node:
		if abs(velocity.y) < min_velocity_for_tilt:
			card_node.rotation_degrees.x = 0
		else:
			var modified_velocity = velocity.y
			modified_velocity += -min_velocity_for_tilt if velocity.y > 0 else min_velocity_for_tilt

			var vertical_tilt = clamp(
				-modified_velocity * tilt_strength,
				-max_tilt_angle, max_tilt_angle)

			card_node.rotation_degrees.x = -vertical_tilt

		if abs(velocity.x) < min_velocity_for_tilt:
			card_node.rotation_degrees.y = 0
		else:
			var modified_velocity = velocity.x
			modified_velocity += -min_velocity_for_tilt if velocity.x > 0 else min_velocity_for_tilt
			var horizontal_tilt = clamp(
				modified_velocity * tilt_strength, -max_tilt_angle,
				max_tilt_angle)
			card_node.rotation_degrees.y = horizontal_tilt


func get_global_rect() -> Rect2:
	if sprite and sprite.texture:
		var size = sprite.texture.get_size() * sprite.scale
		var top_left = global_position - size * 0.5
		return Rect2(top_left, size)
	return Rect2()
