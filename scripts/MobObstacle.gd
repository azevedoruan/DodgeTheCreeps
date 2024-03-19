extends RigidBody2D

class_name MobObstacle

@export var min_speed : int = 60
@export var max_speed : int = 140

var my_player : Node2D
var friction : float = 20
var start_freezing : bool = false


func _ready():
	$AnimatedSprite2D.play("walk")
	
	# determina sua direção e velocidade
	var speed = randi_range(min_speed, max_speed)
	if my_player.position.x < position.x:
		set_linear_velocity(Vector2.LEFT * max_speed)
		set_rotation(PI)
	else:
		set_linear_velocity(Vector2.RIGHT * max_speed)


func _physics_process(delta):
	if get_linear_velocity().x < 0:
		linear_velocity.x += friction * delta
	else:
		linear_velocity.x += -friction * delta
	
	if start_freezing == false and linear_velocity.length() < 3:
		$AnimatedSprite2D.play("freezing")
		start_freezing = true
	
	if linear_velocity.length() < 1:
		set_physics_process(false)
		$Timer.start()


func set_default_behaviour(location: Vector2, player: Node2D) -> void:
	position = location
	my_player = player


func set_custom_behaviour(location: Vector2, direction: float) -> void:
	position = location
	print("A direção de ", name, " não pode ser modificada")


func _on_timer_timeout():
	queue_free()
