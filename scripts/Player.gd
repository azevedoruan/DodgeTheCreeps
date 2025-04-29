extends Area2D
class_name Player

signal hit

@export var joystick_handler: JoyStickHandler
@export var is_immortal: bool = false

var screen_size

const SPEED: float = 185


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	var velocity: Vector2 = joystick_handler.direction
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta * SPEED
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if abs(velocity.x) > abs(velocity.y):
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif abs(velocity.y) > abs(velocity.x):
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = true if velocity.y > 0 else false


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
		$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body:
		if body.is_in_group("mobs"):
			if is_immortal == false:
				hide()
				hit.emit()
				$CollisionShape2D.set_deferred("disabled", true)
