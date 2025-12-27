class_name SceneStateMachine extends Node

var scenes: Array[Scene] = []
var curr_scene: Scene = null
var prev_scene: Scene = null
var last_hour: int = -1
var current_weather: String = "Clear" # default

@export var weather_conditions_path: NodePath
@onready var weather_conditions = get_node(weather_conditions_path)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Collect all child scenes
	for child in get_children():
		if child is Scene:
			scenes.append(child)
	
	if scenes.size() == 0:
		return
	
	if WeatherManager:
		WeatherManager.weather_updated.connect(_on_weather_updated)
	else:
		print("WeatherManager singleton not found!")

	_update_scene_by_time_and_weather()
	process_mode = Node.PROCESS_MODE_INHERIT
	
	#print("WeatherConditions path:", weather_conditions_path)
	#print("WeatherConditions node:", weather_conditions)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if curr_scene:
		ChangeScene(curr_scene.Process(delta))
	_check_hour_change()
	pass

func _physics_process(delta: float) -> void:
	if curr_scene:
		ChangeScene(curr_scene.Physics(delta))
	pass

func _unhandled_input(event: InputEvent) -> void:
	if curr_scene:
		ChangeScene(curr_scene.HandleInput(event))

# ----- Hour Check -----
func _check_hour_change() -> void:
	var current_hour = Time.get_datetime_dict_from_system().hour
	if current_hour != last_hour:
		last_hour = current_hour
		_update_scene_by_time_and_weather()
		
# ----- Weather Update -----
func _on_weather_updated(weather: String) -> void:
	current_weather = weather
	print("Weather updated:", current_weather)

	# Option 2: Let the current scene handle the new weather directly
	if curr_scene:
		curr_scene.Enter(current_weather, weather_conditions)

# ----- Decide scene based on hour + weather -----
func _update_scene_by_time_and_weather() -> void:
	var hour = Time.get_datetime_dict_from_system().hour
	
	var hour_matched_scenes = []
	for s in scenes:
		if s.IsActiveForHour(hour):
			hour_matched_scenes.append(s)
	
	if hour_matched_scenes.size() == 0:
		# No scene matches hour, fallback to first scene
		if scenes.size() > 0:
			ChangeScene(scenes[0])
			return

	# Try to match weather within hour-matched scenes
	for s in hour_matched_scenes:
		if current_weather in s.allowed_weathers:
			ChangeScene(s)
			return
	
	# If no weather match, just pick the first hour-matched scene
	ChangeScene(hour_matched_scenes[0])


# ----- Scene Change -----
func ChangeScene(new_scene: Scene) -> void:
	if new_scene == null or new_scene == curr_scene:
		return
	if curr_scene:
		curr_scene.Exit()
	
	prev_scene = curr_scene
	curr_scene = new_scene
	curr_scene.Enter(current_weather, weather_conditions)
	
	print("Switched to scene: ", curr_scene.name)
	
