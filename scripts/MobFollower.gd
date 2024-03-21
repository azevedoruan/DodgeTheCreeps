extends CharacterBody2D
class_name MobFollower

@onready var eye: Sprite2D = $Eye
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 100.0

var _player: Node2D
var _current_direction: float


func set_player(player: Node2D) -> void:
	_player = player

func set_current_direction(direction: float) -> void:
	_current_direction = direction


func _ready():
	animated_sprite.play("walk")
	set_rotation(_current_direction)


func _process(delta):
	eye.look_at(_player.position)
	_current_direction = get_angle_to(_player.position)
	rotation += clampf(_current_direction, -0.61, 0.61) * delta
	velocity = transform.x * speed
	move_and_slide()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
