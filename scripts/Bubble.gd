extends Sprite2D
class_name Bubble

signal on_invisible(Bubble)

const SPEED: float = 10.0

var shape_rid: RID

var _shape_params: PhysicsShapeQueryParameters2D
var _direct_space_state: PhysicsDirectSpaceState2D
var _player_node: Node2D = null
var _acceleration: float


func _ready() -> void:
	set_process(false)
	
	visibility_changed.connect(_on_is_visible)
	
	_direct_space_state = get_world_2d().direct_space_state
	
	_acceleration = SPEED
	
	_shape_params = PhysicsShapeQueryParameters2D.new()
	_shape_params.set_shape_rid(shape_rid)
	_shape_params.collide_with_areas = true
	_shape_params.collide_with_bodies = false
	_shape_params.collision_layer = 1
	_shape_params.transform = transform


func _process(delta: float) -> void:
	# move o bubble em direção ao player
	var distance: Vector2 = (_player_node.position - position).normalized()
	position += distance * _acceleration * delta
	_acceleration += SPEED * 0.25
	
	if position.distance_to(_player_node.position) < 10:
		_player_node = null
		_acceleration = SPEED
		set_process(false)
		on_invisible.emit(self)
		hide()


func _physics_process(_delta: float) -> void:
	# checar colisão com o player
	var result: Array[Dictionary] = _direct_space_state.intersect_shape(_shape_params, 1)
	if result:
		var other = result[0]["collider"]
		if other.is_in_group("player"):
			_player_node = other
			set_physics_process(false)
			set_process(true)


func _on_is_visible() -> void:
	if visible == true:
		# atualiza a nova posição e "ativa" o detector de colisões
		_shape_params.transform = transform
		set_physics_process(true)
