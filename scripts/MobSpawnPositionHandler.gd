extends Node
class_name MobSpawnPositionHandler

@export var spawn_position_offset: float

var _axis_x_left: float
var _axis_x_right: float
var _axis_y_top: float
var _axis_y_bottom: float


func _ready():
	# prepara as posições do spawn
	var root = get_tree().root
	_axis_x_left = 0
	_axis_x_right = Vector2(root.content_scale_size).x
	_axis_y_top = 0
	_axis_y_bottom = Vector2(root.content_scale_size).x / (Vector2(root.size).x / Vector2(root.size).y)


func get_horizontal_random_position() -> Positions:
	var positions: Positions = Positions.new()
	
	# determina a posição no eixo y
	var m_min: int = int(_axis_y_top + (_axis_y_bottom * 0.10))
	var m_max: int = int(_axis_y_bottom - (_axis_y_bottom * 0.10))
	positions.mob_position.y = randi_range(m_min, m_max)
	positions.shadow_positon.y = positions.mob_position.y
	
	# determina a posição no eixo x
	if randf() < 0.5:
		positions.mob_position.x = _axis_x_left - spawn_position_offset
		positions.shadow_positon.x = _axis_x_left
	else:
		positions.mob_position.x = _axis_x_right + spawn_position_offset
		positions.shadow_positon.x = _axis_x_right
	
	return positions


func get_vertical_random_position() -> Positions:
	var positions: Positions = Positions.new()
	
	# determina a posição no eixo x
	var m_min: int = int(_axis_x_left + (_axis_x_right * 0.07))
	var m_max: int = int(_axis_x_right - (_axis_x_right * 0.07))
	positions.mob_position.x = randi_range(m_min, m_max)
	positions.shadow_positon.x = positions.mob_position.x
	
	# determina a posição no eixo y
	if randf() < 0.5:
		positions.mob_position.y = _axis_y_top - spawn_position_offset
		positions.shadow_positon.y = _axis_y_top
	else:
		positions.mob_position.y = _axis_y_bottom + spawn_position_offset
		positions.shadow_positon.y = _axis_y_bottom
	
	return positions


func get_horizontal_positions(side: String, axis_y: float) -> Positions:
	var positions: Positions = Positions.new()
	
	# determina a posição no eixo x
	if side == "left":
		positions.mob_position.x = _axis_x_left - spawn_position_offset
		positions.shadow_positon.x = _axis_x_left
	else:
		positions.mob_position.x = _axis_x_right + spawn_position_offset
		positions.shadow_positon.x = _axis_x_right
	
	# determina posição no eixo y
	positions.mob_position.y = axis_y
	positions.shadow_positon.y = axis_y
	
	return positions


func get_vertical_positions(place: String, axis_x: float) -> Positions:
	var positions: Positions = Positions.new()
	
	# determina posição no eixo x
	positions.mob_position.x = axis_x
	positions.shadow_positon.x = axis_x
	
	# determina posição no eixo y
	if place == "top":
		positions.mob_position.y = _axis_y_top - spawn_position_offset
		positions.shadow_positon.y = _axis_y_top
	else:
		positions.mob_position.y = _axis_y_bottom + spawn_position_offset
		positions.shadow_positon.y = _axis_y_bottom
	
	return positions
