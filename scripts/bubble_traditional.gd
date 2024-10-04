extends Area2D
class_name BubbleTraditional

signal on_invisible(BubbleTraditional, bool)

@onready var _collision: CollisionShape2D = $CollisionShape2D
@onready var _sprite: Sprite2D = $Sprite2D

const SPEED: float = 80.0

var _player_node: Node2D = null
var _acceleration: float
var _is_mature: bool = false


func _ready() -> void:
	_acceleration = SPEED
	set_process(false)


func _process(delta: float) -> void:
	# move o bubble em direção ao player
	var distance: Vector2 = (_player_node.position - position).normalized()
	var motion: Vector2 = distance * _acceleration
	position += motion * delta
	_acceleration += (SPEED * SPEED) * delta
	
	if position.distance_to(_player_node.position) < 10:
		_player_node = null
		_acceleration = SPEED
		set_process(false)
		on_invisible.emit(self, true)
		hide()


func restart() -> void:
	_collision.set_deferred("disabled", false)
	_sprite.modulate = Color("1a7478")
	_sprite.scale = Vector2.ZERO
	visible = true
	
	# define a escala e cor
	var _tween: Tween = create_tween()
	_tween.tween_property(_sprite, "scale", Vector2.ONE * 0.30, 2.0)
	_tween.tween_property(_sprite, "modulate", Color("8cf1f6"), 2.0)
	_tween.tween_callback(func():
		var param_scale: float = randf_range(0.40, 0.525)
		_sprite.scale = Vector2.ONE * param_scale
		_sprite.modulate = Color.WHITE
		_is_mature = true
	)


func reset() -> void:
	_collision.set_deferred("disabled", true)
	_is_mature = false
	on_invisible.emit(self, false)
	hide()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and _is_mature:
		_is_mature = false
		_collision.set_deferred("disabled", true)
		_player_node = area
		set_process(true)
	elif area.is_in_group("explosion"):
		reset()
