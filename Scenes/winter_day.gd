class_name WinterDay extends Scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_hour = 5
	end_hour = 20
	pass # Replace with function body.

func Enter() -> void:
	print("Entering WinterDay")
	var light = get_node("../../DirectionalLight3D") as DirectionalLight3D
	if light:
		light.light_energy = 5
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
