extends RigidBody2D
class_name MobFlash

@export var speed: float = 240


func _ready():
	$AnimatedSprite2D.play("flash")
	set_linear_velocity(Vector2(speed, 0).rotated(rotation))


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
