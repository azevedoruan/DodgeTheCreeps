class_name Utility extends Node

var is_on_computer: bool
var is_on_mobile: bool
var is_on_ios: bool
var is_on_android: bool

var _log_label: Label = null


func _init() -> void:
	_set_platform_variables()


func print_message_log(message: String) -> void:
	if !_log_label:
		_log_label = get_tree().get_first_node_in_group("debug_console").find_child("LogLabel")
	
	_log_label.text += message
	_log_label.text += "\n"
	print(message)


func _set_platform_variables() -> void:
	var os_name: String = OS.get_name()
	if os_name == "Android" || os_name == "iOS":
		is_on_mobile = true
		if os_name == "Android":
			is_on_android = true
			is_on_ios = false
		else:
			is_on_android = false
			is_on_ios = true
	else:
		is_on_computer = true
		is_on_mobile = false
		is_on_android = false
		is_on_ios = false
	
	print("Utility Initialized")


func save_variable(content: String) -> void:
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_pascal_string(content)
	print("Game saved successfull")


func load_variable() -> String:
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if file != null:
		return file.get_pascal_string()
	
	print("No data saved...")
	return "0"
