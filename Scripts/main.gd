class_name MainClass extends Node3D

#var url = "https://api.openweathermap.org/data/2.5/weather?lat=41.84238640042879&lon=-87.64249600576402&appid=7bd174330b5d9b877ba1b48cce113055&units=imperial"
#var API_KEY = "7bd174330b5d9b877ba1b48cce113055"
#41.84238640042879, -87.64249600576402
#@onready var http_request = $HTTPRequest
@onready var camera = $CameraRoot/CameraPivot/Camera3D
