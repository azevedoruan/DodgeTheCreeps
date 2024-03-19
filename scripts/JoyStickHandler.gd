class_name JoyStickHandler
extends Node

@export var joy_stick: PackedScene

var event_index = -1
var joy_stick_instance: Node2D
var stick: Sprite2D
var distance: float
var direction: Vector2

const RADIUS := 30

func _ready():
	# desabilita os processos de input (esses eventos só devem ser habilitados quando o gameplay iniciar)
	set_process_input(false)
	
	joy_stick_instance = joy_stick.instantiate() as Node2D
	joy_stick_instance.visible = false
	
	# add instância do joy_stick para dentro de main
	get_parent().add_child.call_deferred(joy_stick_instance)
	
	# seleciona o Stick
	stick = joy_stick_instance.get_node("Base/Stick") as Sprite2D


func _input(event):
	# mostra e esconde o joy_stick na posição do toque na tela
	if event is InputEventScreenTouch:
		if event.is_pressed():
			joy_stick_instance.position = Vector2(event.position.x, event.position.y)
			joy_stick_instance.visible = true
			event_index = event.index
		elif event.is_released():
			joy_stick_instance.visible = false
			stick.position = Vector2.ZERO
			direction = Vector2.ZERO
	
	if event is InputEventScreenDrag and event_index != -1:
		# calcula o tamanho e direcão do arrasto do toque na tela
		distance = (joy_stick_instance.position).distance_to(event.position)
		direction = (event.position - joy_stick_instance.position).normalized()
		
		if distance > RADIUS:
			distance = RADIUS
		
		# posiciona o stick dentro dos limites da base
		stick.position = distance * direction


func _on_player_hit():
	joy_stick_instance.visible = false
	stick.position = Vector2.ZERO
	direction = Vector2.ZERO
	set_process_input(false)


func _on_hud_start_game():
	set_process_input(true)
