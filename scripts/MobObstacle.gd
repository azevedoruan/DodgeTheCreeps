extends RigidBody2D
class_name MobObstacle

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer_to_destroy: Timer = $Timer

@export var min_speed: int = 60
@export var max_speed: int = 140

var friction: float = 20
var start_freezing: bool = false


func _ready():
	animated_sprite.play("walk")
	
	# determina sua direção e velocidade
	var speed = randi_range(min_speed, max_speed)
	if position.x > 200:
		set_linear_velocity(Vector2.LEFT * speed)
		set_rotation(PI)
	else:
		set_linear_velocity(Vector2.RIGHT * speed)


func _physics_process(delta):
	if get_linear_velocity().x < 0:
		linear_velocity.x += friction * delta
	else:
		linear_velocity.x += -friction * delta
	
	if start_freezing == false and linear_velocity.length() < 3:
		animated_sprite.play("freezing")
		start_freezing = true
	
	if linear_velocity.length() < 1:
		set_physics_process(false)
		timer_to_destroy.start()


func _on_timer_timeout():
	queue_free()
