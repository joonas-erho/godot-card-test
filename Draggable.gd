extends Node2D

var currently_holding := false
var drag_offset := Vector2.ZERO
var velocity := Vector2.ZERO
var sprite: Sprite2D
var target_position := global_position

@export var smooth_speed := 4500.0
@export var max_tilt_angle := 7.5
@export var min_velocity_for_tilt := 100
@export var tilt_strength := 0.001
@export var card_node: Node3D

func _ready():
	sprite = get_node("Sprite2D")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if get_global_rect().has_point(get_global_mouse_position()):
					currently_holding = true
			else:
				currently_holding = false

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
