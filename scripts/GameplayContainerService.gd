class_name GameplayContainerService
extends Node

var begin: Vector2
var end: Vector2
var center: Vector2
var size: Vector2

func _ready() -> void:
	_init_container_position()

func _init_container_position() -> void:
	var container: Control = get_node("../Main/Container/GameplayBorder")
	
	if container == null:
		printerr("Não foi possível buscar o nó GameplayBorder")
	
	begin = container.get_position()
	end = container.get_position() + container.get_size()
	size = end - begin
	
	# localiza o centro (size / 2)
	# desloca para a posição correta ( ... + begin)
	center = (size / 2) + begin
	
	print("begin: {0}\nend: {1}\ncenter: {2}".format([begin, end, center]))

func get_top_left_corner() -> Vector2:
	return begin

func get_top_rigth_corner() -> Vector2:
	return Vector2(end.x, begin.y)

func get_bottom_left_corner() -> Vector2:
	return Vector2(begin.x, end.y)

func get_bottom_rigth_corner() -> Vector2:
	return end
