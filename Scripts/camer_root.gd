class_name CameraRoot extends Node3D

@export var rotate_speed := 0.01
@export var pan_speed := 0.01
@export var zoom_speed := 0.5
@export var min_pitch := -1.2
@export var max_pitch := 1.2

var rotating := false
var panning := false
var pitch := 0.0

@onready var pivot := $CameraPivot
@onready var camera := $CameraPivot/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event):

	# Mouse button state
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			rotating = event.pressed
		elif event.button_index == MOUSE_BUTTON_MIDDLE:
			panning = event.pressed

		# Zoom
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			camera.position.z -= zoom_speed
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			camera.position.z += zoom_speed

	# Mouse motion
	if event is InputEventMouseMotion:

		# Rotate (debug camera style)
		if rotating:
			rotate_y(-event.relative.x * rotate_speed)

			pitch -= event.relative.y * rotate_speed
			pitch = clamp(pitch, min_pitch, max_pitch)
			pivot.rotation.x = pitch

		# Pan (move left/right/up/down)
		if panning:
			translate_object_local(Vector3(
				-event.relative.x * pan_speed,
				event.relative.y * pan_speed,
				0
			))
