class_name EveningState extends State

var brush : bool = false
var start_hour : int = 18
var end_hour : int = 24

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Enter() -> void:
	print("Entering ", self.name, " state")
	'''
	idler._update_animation("brush")
	animation_player.animation_finished.connect(EndBrush)
	brush = true
	'''
	pass

func Exit() -> void:
	'''
	animation_player.animation_finished.disconnect(EndBrush)
	brush = false
	pass
	'''
	pass

func Process(_delta: float) -> State:
	return null

func Physics(_delta: float) -> State:
	return null

#func HandleInput(_event: InputEvent) -> State:
	#return null

func IsActiveForHour(hour: int) -> bool:
	return hour >= start_hour and hour < end_hour

func EndBrush(_newAnim : String) -> void:
	brush = false
