class_name WManager extends Node

signal weather_updated(weather: String)
@onready var http_request: HTTPRequest = $HTTPRequest

var url = "https://api.openweathermap.org/data/2.5/weather?lat=41.84238640042879&lon=-87.64249600576402&appid=7bd174330b5d9b877ba1b48cce113055&units=imperial"
#var API_KEY = "7bd174330b5d9b877ba1b48cce113055"
#41.84238640042879, -87.64249600576402

var update_interval: float = 600.0 # 10 minutes
var timer: Timer

func _ready() -> void:
	# Timer for periodic weather fetch
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = update_interval
	timer.one_shot = false
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

	# Connect request_completed signal once
	if http_request:
		http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	else:
		http_request = HTTPRequest.new()
		add_child(http_request)
		http_request.connect("request_completed", Callable(self, "_on_request_completed"))

	# Initial fetch
	fetch_weather()

func _on_timer_timeout() -> void:
	fetch_weather()

func fetch_weather() -> void:
	if http_request:
		var err = http_request.request(url)
		if err != OK:
			print("Failed to send HTTP request: ", err)
	else:
		print("No HTTPRequest node available!")

func _on_request_completed(_result, response_code, _headers, _body) -> void:
	if response_code != 200:
		print("Weather fetch failed: ", response_code)
		return
	
	var json = JSON.new()
	var parse_result = json.parse(_body.get_string_from_utf8())
	if parse_result != OK:
		print("JSON parse failed")
		return
	
	var weather = json.get_data()["weather"][0]["main"] # e.g., "Snow", "Rain", "Clear"
	emit_signal("weather_updated", weather)
	print(json.get_data())
	print("Weather updated: ", weather)
