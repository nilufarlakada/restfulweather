class_name Winter extends Scene

@onready var light = get_node("../../DirectionalLight3D") # DirectionalLight
var clouds: Node3D
var snow: Node3D
var rain: Node3D
var allowed_weathers: Array = ["Clouds", "Snow", "Rain", "Clear"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_hour = 0
	end_hour = 23
	
	pass # Replace with function body.

# --- Called when scene enters ---
func Enter(weather: String, weather_conditions: Node) -> void:
	# Cache weather nodes once
	if clouds == null:
		clouds = weather_conditions.get_node("Clouds") as Node3D
	if snow == null:
		snow = weather_conditions.get_node("Snow") as Node3D
	if rain == null:
		rain = weather_conditions.get_node("Rain") as Node3D
	
	# Show the current weather
	clouds.visible = weather == "Clouds"
	snow.visible = weather == "Snow"
	rain.visible = weather == "Rain"

# --- Called when scene exits ---
func Exit() -> void:
	# Optionally hide all effects
	if clouds:
		clouds.visible = false
	if snow:
		snow.visible = false
	if rain:
		rain.visible = false

func Process(_delta: float) -> Scene:
	# Map hour 0-23 → light energy 0.1 (night) to 5 (day)
	var hour = Time.get_datetime_dict_from_system().hour
	var target_energy = lerp(0.1, 5.0, clamp(float(hour - 6) / 12.0, 0.0, 1.0))
	light.light_energy = lerp(light.light_energy, target_energy, 0.02)
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
