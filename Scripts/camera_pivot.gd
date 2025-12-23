class_name CameraPivot extends Node3D

@export var rotate_speed := 0.01
@export var min_pitch := -1.2
@export var max_pitch := 1.2

var dragging := false
var pitch := 0.0

@onready var camera := $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event):
	# Start / stop dragging
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		dragging = event.pressed

	# Rotate while dragging
	if dragging and event is InputEventMouseMotion:
		rotate_y(-event.relative.x * rotate_speed)

		pitch -= event.relative.y * rotate_speed
		pitch = clamp(pitch, min_pitch, max_pitch)
		camera.rotation.x = pitch
