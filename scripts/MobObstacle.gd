extends RigidBody2D
class_name MobObstacle

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var SPEED: int = 45

func _ready():
	animated_sprite.play("walk")
	
	# determina sua direção e velocidade
	linear_damp = 0.0
	linear_damp_mode = RigidBody2D.DAMP_MODE_REPLACE
	if position.x > 200:
		set_rotation(PI)
		set_linear_velocity(Vector2.LEFT * SPEED)
	else:
		set_linear_velocity(Vector2.RIGHT * SPEED)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
