class_name StateMachine extends Node

var states: Array[State]
var prev_state
var curr_state
var last_hour : int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ChangeState(curr_state.Process(delta))
	
	# Check for hour change
	var now_dict = Time.get_datetime_dict_from_system()
	var current_hour = now_dict.hour
	if current_hour != last_hour:
		last_hour = current_hour
		# pick the state for this hour
		for s in states:
			if s.IsActiveForHour(current_hour):
				ChangeState(s)
				break
	pass

func _physics_process(delta: float) -> void:
	ChangeState(curr_state.Physics(delta))
	pass

func _unhandled_input(event: InputEvent) -> void:
	ChangeState(curr_state.HandleInput(event))
	pass

func Initialize(_idler : Idler) -> void:
	states = []

	# Collect all child states
	for c in get_children():
		if c is State:
			states.append(c)

	if states.size() == 0:
		return

	# Assign the Idler to all states
	for s in states:
		s.idler = _idler

	# Determine current Chicago hour
	var now_dict = Time.get_datetime_dict_from_system()
	var hour = now_dict.hour
	
	print("Current hour: ", hour)
	
	var initial_state : State = null

	# Choose state based on hour
	for s in states:
		# You can give each state a 'start_hour' and 'end_hour' property
		if s.IsActiveForHour(hour):
			initial_state = s
			break

	# fallback: if none matched, just pick the first
	if initial_state == null:
		initial_state = states[0]

	ChangeState(initial_state)
	process_mode = Node.PROCESS_MODE_INHERIT

func ChangeState(state: State) -> void:
	
	if state == null || state == curr_state:
		return
	
	if curr_state:
		curr_state.Exit()
	
	prev_state = curr_state
	curr_state = state
	curr_state.Enter()
	
	print("Switched to state: ", curr_state.name)
	
