class_name MobPositionService
extends Node

var spawn_position_offset: float = 30.0

# valor para desolcar a posição do spawn do mob.
# objetivo de evitar spawns nos cantos da área
const OFFSET_AVOID_CORNERS: float = 40.0

var _axis_x_left: float
var _axis_x_right: float
var _axis_y_top: float
var _axis_y_bottom: float


func init_positions() -> void:
	# prepara as posições do spawn
	#var root = get_tree().root
	#_axis_x_left = 0
	#_axis_x_right = Vector2(root.content_scale_size).x
	#_axis_y_top = 0
	#_axis_y_bottom = Vector2(root.content_scale_size).x / (Vector2(root.size).x / Vector2(root.size).y)
	
	_axis_x_left = GameplayContainerServiceNode.begin.x
	_axis_x_right = GameplayContainerServiceNode.end.x
	_axis_y_top = GameplayContainerServiceNode.begin.y
	_axis_y_bottom = GameplayContainerServiceNode.end.y


func get_horizontal_random_position() -> Positions:
	var positions: Positions = Positions.new()
	
	# determina a posição no eixo y
	var m_min: int = int(_axis_y_top + OFFSET_AVOID_CORNERS)
	var m_max: int = int(_axis_y_bottom - OFFSET_AVOID_CORNERS)
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
	var m_min: int = int(_axis_x_left + OFFSET_AVOID_CORNERS)
	var m_max: int = int(_axis_x_right - OFFSET_AVOID_CORNERS)
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
	# ajusta o valor axis_y escolhido para os limites do container
	#var pos_y: float = _axis_y_top + clampf(axis_y, 0.0, GameplayContainerServiceNode.size.y)
	positions.mob_position.y = axis_y
	positions.shadow_positon.y = axis_y
	
	return positions


func get_vertical_positions(place: String, axis_x: float) -> Positions:
	var positions: Positions = Positions.new()
	
	# determina posição no eixo x
	# ajusta o valor axis_x escolhido para os limites do container
	#var pos_x: float = _axis_x_left + clampf(axis_x, 0.0, GameplayContainerServiceNode.size.x)
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
