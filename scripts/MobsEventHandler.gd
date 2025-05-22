extends Node
class_name MobsEventHandler

signal end_event_handler

@export var initial_event_count: int = 0
@export var events: Array[MobEvent]

var _event_count: int = 0


func restart_events() -> void:
	_event_count = initial_event_count


# dispara os eventos em ordem no decorrer do jogo.
func fire_event(mob_spawner: MobSpawner, player: Player) -> void:
	if player.visible == false:
		return
	
	var event_index = 0
	if _event_count < events.size():
		event_index = _event_count
	else:
		event_index = randi_range(0, events.size() - 1)
	
	var tween: Tween = create_tween()
	var event: MobEvent = events[event_index]
	
	if not event.end_event.is_connected(_on_event_end):
		event.end_event.connect(_on_event_end)
	
	event.fire(mob_spawner, player, tween)
	_event_count += 1


#TEST for development debug
func fire_a_event(mob_spawner: MobSpawner, player: Player, event_index: int = 0) -> void:
	var tween: Tween = create_tween()
	var event: MobEvent = events[event_index]
	event.fire(mob_spawner, player, tween)


func _on_event_end() -> void:
	end_event_handler.emit()
