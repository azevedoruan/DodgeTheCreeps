extends RigidBody2D
class_name MobCommon

@export var swim_min_speed := 100
@export var walk_min_speed := 130
@export var fly_min_speed := 200
@export var range_to_max_speed := 10
@export var mob_types: Array

var my_velocity: Vector2
var my_direction: float = 0
var custom_behaviour: bool = false


func _ready():
	custom_integrator = true
	
	if process_mode == PROCESS_MODE_DISABLED:
		set_process_mode(Node.PROCESS_MODE_INHERIT)
	
	# play animation
	

#func _custom_behaviour(position: Vector2, rotation: float, velocity: float) -> void:
#var direction_rad = deg_to_rad(rotation)
#	set_position(p_position)
#	set_rotation(direction_rad)
#	$AnimatedSprite2D.autoplay = "walk"
#	my_velocity = Vector2(walk_min_speed, 0).rotated(direction_rad)

func set_custom_behaviour(p_position: Vector2, direction: float) -> void:
	var direction_rad = deg_to_rad(direction)
	set_position(p_position)
	set_rotation(direction_rad)
	$AnimatedSprite2D.autoplay = "walk"
	my_velocity = Vector2(walk_min_speed, 0).rotated(direction_rad)


func set_default_behaviour(p_positon: Vector2, player: Node2D) -> void:
	set_position(p_positon)
	
	# escolhe o tipo do mob
	var chosen_mob = null
	if player.get_parent().score < 10:
		chosen_mob = mob_types[0]
	elif player.get_parent().score >= 10:
		chosen_mob = mob_types[randi_range(0, 2)]
	
	$AnimatedSprite2D.autoplay = chosen_mob
	
	# determina a velocidade e direção
	my_velocity = Vector2.ZERO
	my_direction = position.angle_to_point(player.position)
	var current_velocity = Vector2.ZERO
	match chosen_mob:
		"swim":
			current_velocity = Vector2(randi_range(swim_min_speed, swim_min_speed + range_to_max_speed), 0)
			var rad = deg_to_rad(10)
			my_direction += randf_range(-rad, rad)
		"walk":
			current_velocity = Vector2(randi_range(walk_min_speed, walk_min_speed + range_to_max_speed), 0)
			var rad = deg_to_rad(20)
			my_direction += randf_range(-rad, rad)
		"fly":
			current_velocity = Vector2(randi_range(fly_min_speed, fly_min_speed + range_to_max_speed), 0)
			var rad = deg_to_rad(45)
			my_direction += randf_range(-rad, rad)
	my_velocity = current_velocity.rotated(my_direction)
	set_rotation(my_direction)


func _integrate_forces(state):
	state.set_linear_velocity(my_velocity)


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
