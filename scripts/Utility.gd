extends Node

var log_label: Label = null

func print_message_log(message: String) -> void:
	if !log_label:
		log_label = get_tree().get_first_node_in_group("debug_console").find_child("LogLabel")
	
	log_label.text += message
	log_label.text += "\n"
	print(message)

func get_window_scaled() -> Vector2:
	var os_name: String = OS.get_name()
	if os_name == "Android" || os_name == "iOS":
		var window_y_scaled: float = (float(get_tree().root.content_scale_size.x) / float(get_tree().root.content_scale_size.y)) * get_tree().root.size.y
		var window_scaled: Vector2 = Vector2(get_tree().root.content_scale_size.x, window_y_scaled)
		return window_scaled
	else:
		return get_tree().root.content_scale_size
