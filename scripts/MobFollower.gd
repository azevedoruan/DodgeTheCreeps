extends CharacterBody2D

class_name MobFollower

@export var speed: float = 100.0
@onready var eye: Sprite2D = $Eye
var my_player: Node2D
var current_direction: float


func _ready():
	set_rotation(current_direction)


func _process(delta):
	eye.look_at(my_player.position)
	current_direction = get_angle_to(my_player.position)
	rotation += clampf(current_direction, -0.61, 0.61) * delta
	velocity = transform.x * speed
	move_and_slide()


func set_default_behaviour(location: Vector2, player: Node2D) -> void:
	position = location
	my_player = player
	$AnimatedSprite2D.play("walk")
	current_direction = position.angle_to_point(my_player.position)


func set_custom_behaviour(location: Vector2, direction: float) -> void:
	print(name, " definido como 'custom behaviuor'")


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
