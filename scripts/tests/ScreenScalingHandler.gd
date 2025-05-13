class_name ScreenScalingHandler
extends MarginContainer

func _ready() -> void:
	add_theme_constant_override("margin_top", 60)
	add_theme_constant_override("margin_bottom", 30)
	add_theme_constant_override("margin_left", 12)
	add_theme_constant_override("margin_right", 12)
