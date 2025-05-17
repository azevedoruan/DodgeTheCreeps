class_name LinesDebug2D
extends Control

@export var color: Color
@export var line_width: float = 1.0

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), color, false, line_width)
