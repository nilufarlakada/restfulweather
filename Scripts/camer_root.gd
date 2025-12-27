class_name CameraRoot extends Node3D

# --- Settings ---
@export var rotate_speed := 0.01
@export var pan_speed := 0.01
@export var zoom_speed := 0.5
@export var min_pitch := -1.2
@export var max_pitch := 1.2

# --- Zoom limits ---
@export var min_zoom := 2.0
@export var max_zoom := 20.0

# --- State variables ---
var rotating := false
var panning := false
var dragging_window := false
var drag_offset := Vector2i.ZERO
var pitch := 0.0

# --- Nodes ---
@onready var pivot := $CameraPivot
@onready var camera := $CameraPivot/Camera3D

func _ready():
	# Show cursor (we want visible mouse)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event):

	# --------------------------
	# Mouse button press/release
	# --------------------------
	if event is InputEventMouseButton:

		# Right click → rotate camera
		if event.button_index == MOUSE_BUTTON_RIGHT:
			rotating = event.pressed

		# Middle click → pan
		elif event.button_index == MOUSE_BUTTON_MIDDLE:
			panning = event.pressed

		# Left click → drag window
		elif event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if rotating:  # prevent window drag while rotating camera
					return
				dragging_window = true
				drag_offset = get_window().position - Vector2i(DisplayServer.mouse_get_position())
				Input.set_default_cursor_shape(Input.CURSOR_MOVE)
			else:
				dragging_window = false
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)

		# Scroll wheel → zoom
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			camera.position.z = clamp(camera.position.z - zoom_speed, min_zoom, max_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			camera.position.z = clamp(camera.position.z + zoom_speed, min_zoom, max_zoom)

	# --------------------------
	# Mouse motion
	# --------------------------
	if event is InputEventMouseMotion:

		# Rotate camera
		if rotating:
			# horizontal
			rotate_y(-event.relative.x * rotate_speed)
			# vertical
			pitch -= event.relative.y * rotate_speed
			pitch = clamp(pitch, min_pitch, max_pitch)
			pivot.rotation.x = pitch

		# Pan camera
		if panning:
			translate_object_local(Vector3(
				-event.relative.x * pan_speed,
				event.relative.y * pan_speed,
				0
			))

		# Drag window
		if dragging_window:
			get_window().position = Vector2i(DisplayServer.mouse_get_position()) + drag_offset
