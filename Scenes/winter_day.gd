class_name WinterDay extends Scene

#@onready var clouds = get_node("/root/Main/WeatherConditions/Clouds")
@onready var light = get_node("../../DirectionalLight3D")
var allowed_weathers: Array = ["Clouds", "Snow", "Rain", "Clear"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_hour = 5
	end_hour = 20
	
	# Reset everything
	#clouds.visible = false
	#snow.visible = false
	#rain.visible = false
	pass # Replace with function body.

func Enter(weather: String, _wc: Node) -> void:
	print("Entering WinterDay")
	
	var clouds = _wc.get_node("Clouds")
	print("Clouds node visible before:", clouds.visible)
	print(weather)
	clouds.visible = weather == "Clouds"
	print("Clouds node visible after:", clouds.visible)
	
	if light:
		light.light_energy = 5

	match weather:
		"Clouds", "Cloudy":
			#var clouds = _wc.get_node("Clouds")
			clouds.visible = weather == "Clouds"
		"Clear":
			pass # everything stays hidden

	# Set background, particle effects, etc.

func Exit() -> void:
	print("Exiting WinterDay")

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
