@tool
extends EditorPlugin

const main_panel = preload("res://addons/uedatabases/Databases.tscn")
var main_panel_instance:Control

func _enter_tree():
	initiate_plugin()
	
	connect_signals()
	list_databases()
#
# connect ui element signals to functions
func connect_signals()->void:
	main_panel_instance.find_child("NewDatabase").connect("pressed", new_database)
#
# Button "New" pressed
func new_database():
	print("New database")
	
func delete_database()->void:
	pass
	
func clear_database()->void:
	pass
#
# list all existing databases in the left container
func list_databases()-> void:
	var container = main_panel_instance.find_child("DatabasesContainer")
	var header:Label = Label.new()
	header.text = "Your databases"
	container.add_child(header)
	
	for key in Databases.get_data():
		var btn:Button = Button.new()
		btn.text = key
		btn.name = key
		btn.pressed.connect(show_database_content.bind(key))
		container.add_child(btn)

func show_database_content(key:String)->void:
	# activate buttons
	var delete_db:Button = main_panel_instance.find_child("DeleteDatabase")
	var clear_db:Button = main_panel_instance.find_child("ClearDatabase")
	
	delete_db.disabled = false
	clear_db.disabled = false
		
	# get the database content container ...
	var container = main_panel_instance.find_child("DatabaseContentContainer")
	# ... and clear it
	for entry in container.get_children():
		container.remove_child(entry)
	
	# get the dictionary for the given key
	var dict:Dictionary = Databases.get_data()[key]
		
	# create ui for renaming the database name
	var db_name_label:Label = Label.new()
	db_name_label.text = "Database Name"
	db_name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT	
	var db_name_edit:LineEdit = LineEdit.new()
	db_name_edit.text = key
	
	var hor_line:HBoxContainer = HBoxContainer.new()
	hor_line.add_child(db_name_label)
	hor_line.add_child(db_name_edit)
	
	container.add_child(hor_line)
	container.add_child(HSeparator.new())
	
	var data:Dictionary = Databases.get_data()[key]
	for dbkey in data:
		hor_line = HBoxContainer.new()
		var lbl_key_edit:Label = Label.new()
		var lbl_key_value:Label = Label.new()
		var key_edit:LineEdit = LineEdit.new()
		var value_edit:LineEdit = LineEdit.new()
		
		lbl_key_edit.text = "Key"
		lbl_key_value.text = "Value"
		
		key_edit.text = dbkey
		value_edit.text = str(data[dbkey])
		
		hor_line.add_child(lbl_key_edit)
		hor_line.add_child(key_edit)
		hor_line.add_child(lbl_key_value)
		hor_line.add_child(value_edit)
		
		container.add_child(hor_line)
	
	# add plus button	
	container.add_child(HSeparator.new())
	hor_line = HBoxContainer.new()
	var add_button:Button = Button.new()
	add_button.text = "Add row"
	container.add_child(add_button)


#
# Plugin funcs
func initiate_plugin()->void:
	add_autoload_singleton("Databases", "res://addons/uedatabases/Database.gd")
	
	main_panel_instance = main_panel.instantiate()
	EditorInterface.get_editor_main_screen().add_child(main_panel_instance)
	_make_visible(false)
func _exit_tree():
	if main_panel_instance:
		main_panel_instance.queue_free()
func _has_main_screen():
	return true
func _make_visible(visible):
	pass
func _get_plugin_name():
	return "Databases"
func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("PopupMenu", "EditorIcons")
