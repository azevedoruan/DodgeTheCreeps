extends Node
class_name JoyStickHandler

@export var joy_stick: PackedScene

var event_index = -1
var joy_stick_instance: Node2D
var stick: Sprite2D
var distance: float
var direction: Vector2

const STICK_DISTANCE_LIMIT_RADIUS: float = 30.0
const JOYSTICK_DISTANCE_LIMIT_RADIUS: float = 65.0


func _ready():
	# desabilita os processos de input (esses eventos só devem ser habilitados quando o gameplay iniciar)
	set_process_input(false)
	
	joy_stick_instance = joy_stick.instantiate() as Node2D
	joy_stick_instance.visible = false
	
	var start_pos: Vector2 = MyUtility.get_window_scaled()
	joy_stick_instance.position = Vector2(start_pos.x / 2, start_pos.y - 100)
	get_parent().add_child.call_deferred(joy_stick_instance)
	
	stick = joy_stick_instance.get_node("Base/Stick") as Sprite2D


func _input(event):
	# aciona o joy_stick e sua posição
	if event is InputEventScreenTouch:
		if event.is_pressed():
			if joy_stick_instance.position.distance_to(event.position) < JOYSTICK_DISTANCE_LIMIT_RADIUS:
				event_index = event.index
		elif event.is_released():
			stick.position = Vector2.ZERO
			direction = Vector2.ZERO
			event_index = -1
	
	if event is InputEventScreenDrag and event_index != -1:
		# calcula o tamanho e direcão do arrasto do toque na tela
		distance = (joy_stick_instance.position).distance_to(event.position)
		direction = (event.position - joy_stick_instance.position).normalized()
		
		# limita a distancia para manter o stick dentro da base
		if distance > STICK_DISTANCE_LIMIT_RADIUS:
			distance = STICK_DISTANCE_LIMIT_RADIUS
		
		stick.position = distance * direction


func _on_player_hit():
	joy_stick_instance.visible = false
	stick.position = Vector2.ZERO
	direction = Vector2.ZERO
	set_process_input(false)


func _on_hud_start_game():
	set_process_input(true)
	joy_stick_instance.visible = true
