extends Node
class_name MobSpawnPositionHandler

@export var spawn_position_offset: float

var axis_x_left: float
var axis_x_right: float
var axis_y_top: float
var axis_y_bottom: float


func _ready():
	# prepara as posições do spawn
	var root = get_tree().root
	axis_x_left = 0
	axis_x_right = Vector2(root.content_scale_size).x
	axis_y_top = 0
	axis_y_bottom = Vector2(root.content_scale_size).x / (Vector2(root.size).x / Vector2(root.size).y)


func get_horizontal_random_position() -> Positions:
	var positions: Positions = Positions.new()
	
	# determina a posição no eixo y
	var m_min: int = axis_y_top + (axis_y_bottom * 0.10)
	var m_max: int = axis_y_bottom - (axis_y_bottom * 0.10)
	positions.mob_position.y = randi_range(m_min, m_max)
	positions.shadow_positon.y = positions.mob_position.y
	
	# determina a posição no eixo x
	if randf() < 0.5:
		positions.mob_position.x = axis_x_left - spawn_position_offset
		positions.shadow_positon.x = axis_x_left
	else:
		positions.mob_position.x = axis_x_right + spawn_position_offset
		positions.shadow_positon.x = axis_x_right
	
	return positions


func get_vertical_random_position() -> Positions:
	var positions: Positions = Positions.new()
	
	# determina a posição no eixo x
	var m_min: int = axis_x_left + (axis_x_right * 0.07)
	var m_max: int =  axis_x_right - (axis_x_right * 0.07)
	positions.mob_position.x = randi_range(m_min, m_max)
	positions.shadow_positon.x = positions.mob_position.x
	
	# determina a posição no eixo y
	if randf() < 0.5:
		positions.mob_position.y = axis_y_top - spawn_position_offset
		positions.shadow_positon.y = axis_y_top
	else:
		positions.mob_position.y = axis_y_bottom + spawn_position_offset
		positions.shadow_positon.y = axis_y_bottom
	
	return positions


func spawn_custom_horizontal(mob: PackedScene, side: String, location_y_axis: float, targeted: float, velocity: float) -> void:
	var mob_location = Vector2.ZERO
	var shadow_location = Vector2.ZERO
	
	# set x axis position
	if side == "left":
		mob_location.x = axis_x_left - spawn_position_offset
		shadow_location.x = axis_x_left
	elif side == "right":
		mob_location.x = axis_x_right + spawn_position_offset
		shadow_location.x = axis_x_right
	
	# set y axis position
	mob_location.y = location_y_axis
	shadow_location.y = location_y_axis
	
	# start shadow animation
	#var tween = _instantiate_shadow_animation(shadow_location)
	
	# add mob on tree scene
	#tween.tween_callback(func():
	#	var mob_instance: Mob = mob.instantiate()
	#	mob_instance.custom_behaviour(mob_location, targeted, 0)
	#	get_parent().add_child(mob_instance))
