extends RigidBody2D
class_name MobFlash

@export var speed: float = 240

var player_target: Player


func set_player_target(player: Player) -> void:
	player_target = player


func _ready():
	$AnimatedSprite2D.play("flash")
	set_rotation(position.angle_to_point(player_target.position))
	set_linear_velocity(Vector2(speed, 0).rotated(rotation))


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
