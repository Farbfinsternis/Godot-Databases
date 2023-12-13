@tool
extends Node

const data_filename:String = "res://addons/uedatabases/data.json"
var data:Dictionary = {}

func _ready() -> void:
	load_data()
	
func load_data()->void:
	if(FileAccess.file_exists(data_filename)):
		var file:FileAccess = FileAccess.open(data_filename, FileAccess.READ)
		data = JSON.parse_string(file.get_as_text())
		file.close()

func get_data()->Dictionary:
	return data
	
func get_database(key:String)->Dictionary:
	return data[key]
