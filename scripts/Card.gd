class_name Card

extends Node2D

var card_data: CardData
var is_locked := false
var currently_holding := false
var can_be_dragged := true
var face_up := true

# Transformation variables
var target_position: Vector2
var target_rotation_degrees: float
var duration: float
var progress: float

@export var _3d_model: CardNode

func _allow_dragging():
	can_be_dragged = true

## Transforms the card over the given time.
func transform_to(target_pos: Vector2, target_rot: float, anim_duration: float):
	is_locked = true
	target_position = target_pos
	target_rotation_degrees = target_rot
	duration = anim_duration
	progress = 0.0
	await get_tree().create_timer(anim_duration).timeout
	is_locked = false
	print("Done!")

func _flip():
	if _3d_model:
		can_be_dragged = false
		await _3d_model._flip()

func _ready():
	transform_to(Vector2(500,500), 50, 1.0)

func _process(delta):
	# var prev_position = global_position
	if (is_locked):
		progress += delta / duration
		print(progress)
		var time = clamp(progress, 0, 1)
		print(time)
		global_position = global_position.lerp(target_position, time)
		global_rotation_degrees = lerp(global_rotation_degrees, target_rotation_degrees, time)
		# _velocity = (global_position - prev_position) / delta
