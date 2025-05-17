extends Node2D
class_name BubbleHandler

@export var main: Main

const START_TIME: float = 0.4
const BUBBLE_MAX_COUNT: int = 100
const BUBBLE: PackedScene = preload("res://scenes/bubble_traditional.tscn")

var _bubble_count: int = 0
var _invisible_bubbles: Array[BubbleTraditional]
var _spawn_timer: Timer


func reset_bubbles() -> void:
	var _children = get_children()
	for b in _children:
		if b.visible == true:
			b.reset()


func _ready() -> void:
	_spawn_timer = Timer.new()
	_spawn_timer.timeout.connect(_spawn_bubble)
	add_child(_spawn_timer, false, Node.INTERNAL_MODE_FRONT)
	_spawn_timer.start(START_TIME)


func _spawn_bubble() -> void:
	var instance: BubbleTraditional = null
	if _bubble_count < BUBBLE_MAX_COUNT:
		# cria a instancia do body
		instance = BUBBLE.instantiate()
		instance.on_invisible.connect(_on_bubble_is_collected)
		_bubble_count += 1
	else:
		var _bubble = _invisible_bubbles.pop_front()
		# verifica se todos os bubbles foram instanciados e nenhum foi coletado pelo player
		if _bubble != null:
			instance = _bubble
		else:
			return
	
	# define a posição
	instance.position = Vector2(
		randf_range(30.0, MyUtility.get_window_scaled().x - 30.0),
		randf_range(30.0, MyUtility.get_window_scaled().y - 30.0)
	)
	
	if instance.get_parent() == null:
		add_child(instance)
	
	instance.restart()


func _on_bubble_is_collected(bubble: BubbleTraditional, is_collected: bool) -> void:
	_invisible_bubbles.push_back(bubble)
	
	if is_collected:
		main.on_bubble_collected()
