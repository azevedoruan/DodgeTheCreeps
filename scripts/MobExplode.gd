extends RigidBody2D
class_name MobExplode

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer_to_explode: Timer = $TimerToExplode

@export var explosion_fx: PackedScene
@export var min_speed: int = 60
@export var max_speed: int = 140

var _friction: float = 20
var _start_explode: bool = false


func _ready():
	animation_player.play("walk")
	
	# determina sua direção e velocidade
	var speed = randi_range(min_speed, max_speed)
	if position.x > 200:
		set_linear_velocity(Vector2.LEFT * speed)
		set_rotation(PI)
	else:
		set_linear_velocity(Vector2.RIGHT * speed)


func _physics_process(delta) -> void:
	# aplica a fricção
	if get_linear_velocity().x < 0:
		linear_velocity.x += _friction * delta
	else:
		linear_velocity.x += -_friction * delta
	
	if _start_explode == false and linear_velocity.length() < 3:
		animation_player.play("pre_explosion")
		timer_to_explode.start()
		_start_explode = true


func _on_timer_to_explode_timeout():
	var instance = explosion_fx.instantiate()
	instance.set_position(get_position())
	get_parent().add_child(instance)
	queue_free()
