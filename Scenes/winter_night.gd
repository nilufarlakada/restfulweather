class_name WinterNight extends Scene

#@onready var clouds = get_node("../../WeatherConditions/Clouds")
@onready var light = get_node("../../DirectionalLight3D")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_hour = 21
	end_hour = 4

	pass # Replace with function body.

func Enter(weather: String, _wc: Node) -> void:
	print("Entering WinterNight")
	if light:
		light.light_energy = 0.2
	match weather:
		"Clouds", "Cloudy":
			var clouds = _wc.get_node("Clouds")
			clouds.visible = weather == "Clouds"
		"Clear":
			pass # everything stays hidden
	# Set background, particle effects, etc.

func Exit() -> void:
	print("Exiting WinterNight")

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
