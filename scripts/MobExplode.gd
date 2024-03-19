extends RigidBody2D

class_name MobExplode

@export var explosion_fx: PackedScene
@export var min_speed: int = 60
@export var max_speed: int = 140
var my_player: Node2D
var friction: float = 20
var start_explode: bool = false


func _ready():
	$AnimationPlayer.play("walk")
	
	# determina sua direção e velocidade
	var speed = randi_range(min_speed, max_speed)
	if my_player.position.x < position.x:
		set_linear_velocity(Vector2.LEFT * speed)
		set_rotation(PI)
	else:
		set_linear_velocity(Vector2.RIGHT * speed)


func _physics_process(delta) -> void:
	# aplica a fricção
	if get_linear_velocity().x < 0:
		linear_velocity.x += friction * delta
	else:
		linear_velocity.x += -friction * delta
	
	if start_explode == false and linear_velocity.length() < 3:
		$AnimationPlayer.play("pre_explosion")
		$TimerToExplode.start()
		start_explode = true


func set_default_behaviour(location: Vector2, player: Node2D) -> void:
	position = location
	my_player = player


func set_custom_behaviour(location: Vector2, direction: float) -> void:
	position = location
	print("A direção de ", name, " não poder ser modificada")


func _on_timer_to_explode_timeout():
	var instance = explosion_fx.instantiate()
	instance.set_position(get_position())
	get_parent().add_child(instance)
	queue_free()
