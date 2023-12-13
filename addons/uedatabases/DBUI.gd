@tool
extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hö?!?")
	print(tr("KEY_NEW_DATABASE"))
	$MarginContainer/VBox/ButtonsContainer/NewDatabase.text = tr("KEY_NEW_DATABASE")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
