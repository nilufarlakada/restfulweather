class_name Scene extends Node
var start_hour: int = 0
var end_hour: int = 0
#static var idler: Idler
#@onready var label = $"../../UI/MessageLabel"
#@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
#@onready var audio : AudioStreamPlayer2D =  $"../../Audio/AudioStreamPlayer2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Enter() -> void:
	pass

func Exit() -> void:
	pass

func Process(_delta: float) -> Scene:
	return null

func Physics(_delta: float) -> Scene:
	return null
	
func IsActiveForHour(hour: int) -> bool:
	if start_hour <= end_hour:
		return hour >= start_hour and hour <= end_hour
	else:
		# wrap-around case (e.g., 21 to 4)
		return hour >= start_hour or hour <= end_hour

func HandleInput(_event: InputEvent) -> Scene:
	return self
