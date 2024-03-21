extends RigidBody2D
class_name MobCommon

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var swim_min_speed := 100
@export var walk_min_speed := 130
@export var fly_min_speed := 200
@export var range_to_max_speed := 10
@export var mob_types: Array

var _velocity: Vector2
var _animation_name: String = "walk"

# define a velocidade direcionada de acordo com a rotação atual do mob
func set_velocity(velocity: Vector2) -> void:
	_velocity = velocity.rotated(rotation)

func set_animation_name(anim_name: String) -> void:
	_animation_name = anim_name


func _ready():
	custom_integrator = true
	
	if process_mode == PROCESS_MODE_DISABLED:
		set_process_mode(Node.PROCESS_MODE_INHERIT)
	
	animated_sprite.play(_animation_name)


func set_default_behaviour(p_positon: Vector2, player: Node2D) -> void:
	set_position(p_positon)
	
	# escolhe a animação do mob
	if player.get_parent().score < 10:
		set_animation_name(mob_types[0])
	elif player.get_parent().score >= 10:
		set_animation_name(mob_types[randi_range(0, 2)])
	
	# determina a velocidade e direção
	var direction: float = position.angle_to_point(player.position)
	match _animation_name:
		"swim":
			var rad = deg_to_rad(10)
			direction += randf_range(-rad, rad)
			set_rotation(direction)
			set_velocity(Vector2(randi_range(swim_min_speed, swim_min_speed + range_to_max_speed), 0))
		"walk":
			var rad = deg_to_rad(20)
			direction += randf_range(-rad, rad)
			set_rotation(direction)
			set_velocity(Vector2(randi_range(walk_min_speed, walk_min_speed + range_to_max_speed), 0))
		"fly":
			var rad = deg_to_rad(45)
			direction += randf_range(-rad, rad)
			set_rotation(direction)
			set_velocity(Vector2(randi_range(fly_min_speed, fly_min_speed + range_to_max_speed), 0))


func _integrate_forces(state):
	state.set_linear_velocity(_velocity)


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
