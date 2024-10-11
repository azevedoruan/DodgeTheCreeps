extends Node
class_name MobsEventHandler

signal end_event_handler

@export var events: Array[MobEvent]

var _event_count: int = 0


func restart_events() -> void:
	_event_count = 0


# dispara os eventos em ordem com o decorrer do jogo.
func fire_event(mob_spawner: MobSpawner, mob_spawn_pos: MobSpawnPositionHandler, player: Player) -> void:
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
	event.fire(mob_spawner, mob_spawn_pos, player, tween)
	_event_count += 1


func _on_event_end() -> void:
	end_event_handler.emit()
