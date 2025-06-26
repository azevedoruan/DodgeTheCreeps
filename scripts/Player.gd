class_name Player
extends Area2D

signal hit

@export var joystick_handler: JoyStickHandler
@export var is_immortal: bool = false

@onready var _animation_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _collision_shape: CollisionShape2D = $CollisionShape2D

#TODO calcular limites da área de gameplay por meio do GameplayContainerService
var _screen_size: Vector2

const SPEED: float = 185


func _ready():
	_screen_size = get_viewport_rect().size


func _process(delta):
	var velocity: Vector2 = Vector2.ZERO
	if MyUtility.is_on_computer:
		velocity = _move_by_keyboard()
	else:
		velocity = joystick_handler.direction
	
	if velocity.length() > 0:
		_animation_sprite.play()
	else:
		_animation_sprite.stop()
	
	position += velocity * delta * SPEED
	position = position.clamp(Vector2.ZERO, _screen_size)
	
	if abs(velocity.x) > abs(velocity.y):
		_animation_sprite.animation = "walk"
		_animation_sprite.flip_v = false
		_animation_sprite.flip_h = velocity.x < 0
	elif abs(velocity.y) > abs(velocity.x):
		_animation_sprite.animation = "up"
		_animation_sprite.flip_v = true if velocity.y > 0 else false


func _move_by_keyboard():
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	return velocity


# explosion hit
func _on_area_entered(_area):
	if is_immortal == false:
		hide()
		hit.emit()
		_collision_shape.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	_collision_shape.disabled = false


func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body:
		if body.is_in_group("mobs"):
			if is_immortal == false:
				hide()
				hit.emit()
				_collision_shape.set_deferred("disabled", true)
