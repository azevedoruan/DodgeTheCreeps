class_name Positions

var mob_position: Vector2
var shadow_positon: Vector2

func set_new_positions(new: Vector2) -> void:
	mob_position = new
	shadow_positon = new

func set_y(y: float) -> void:
	mob_position.y = y
	shadow_positon.y = y

func set_x(x: float) -> void:
	mob_position.x = x
	shadow_positon.x = x
