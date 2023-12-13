extends Node2D

func _ready() -> void:
	var player:Dictionary = Database.get_database("player")
	print(player.health)
