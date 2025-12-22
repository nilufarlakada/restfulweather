class_name MorningState extends State

var tea : bool = false
var start_hour : int = 0
var end_hour : int = 18

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Enter() -> void:
	print("Entering ", self.name, " state")
	'''
	idler._update_animation("tea")
	animation_player.animation_finished.connect(EndTea)
	tea = true
	'''
	pass

func Exit() -> void:
	'''
	animation_player.animation_finished.disconnect(EndTea)
	tea = false
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

func EndTea(_newAnim : String) -> void:
	tea = false
