class_name SaveManager extends Node
#
#const SAVE_PATH := "user://savegame.json"
#
#var contents_to_save := {
	#"is_snowing": false,
	#"camera_transform": Transform3D.IDENTITY
#}
#
#
#func _ready() -> void:
	#load_game()
#
#func get_camera() -> Camera3D:
	#return get_viewport().get_camera_3d()
#
#func save_game(camera: Camera3D):
	#if camera:
		#contents_to_save["camera_transform"] = camera.global_transform
		#
	#var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	##file.store_string(JSON.stringify(save_data))
	#file.store_var(contents_to_save.duplicate())
	#file.close()
#
#func load_game():
	#if not FileAccess.file_exists(SAVE_PATH):
		#return
#
	#var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	#var data = file.get_var()
	#file.close()
	#
	#var save_data = data.duplicate()
	#
	#if data.has("is_snowing"):
		#contents_to_save["is_snowing"] = data["is_snowing"]
	#if data.has("camera_transform"):
		#contents_to_save["camera_transform"] = data["camera_transform"]
	#
