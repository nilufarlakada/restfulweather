class_name Winter extends Scene

var clouds: Node3D
@onready var light = get_node("../../DirectionalLight3D")
var allowed_weathers: Array = ["Clouds", "Snow", "Rain", "Clear"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_hour = 0
	end_hour = 23
	
	# Reset everything
	#clouds.visible = false
	#snow.visible = false
	#rain.visible = false
	pass # Replace with function body.

func Enter(weather: String, _wc: Node) -> void:
	print("Entering Winter")
	
	if light:
		light.light_energy = 5
		
	if clouds == null:
		clouds =  _wc.get_node("Clouds")

	clouds.visible = weather == "Clouds"

	# Set background, particle effects, etc.

func Exit() -> void:
	print("Exiting Winter")

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
