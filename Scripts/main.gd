class_name MainClass extends Node3D

var url = "https://api.openweathermap.org/data/2.5/weather?lat=41.842329&lon=-447.642481&appid=7bd174330b5d9b877ba1b48cce113055"
#var API_KEY = "7bd174330b5d9b877ba1b48cce113055"
@onready var http_request = $HTTPRequest

#func _ready()-> void:
	#http_request.request_completed.connect(_on_request_completed)
	#send_request()

func send_request():
	var headers = ["Content-Type: application/json"]
	http_request.request(url, headers, HTTPClient.METHOD_GET)
	
func _on_request_completed(_results, _response_code, _head, _body):
	var json = JSON.parse_string(_body.get_string_from_utf8())
	
	print(json)
