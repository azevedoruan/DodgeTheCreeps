class_name MobEventFifth
extends MobEvent

func fire(mob_spawner: MobSpawner, player, tween: Tween) -> void:
	var height_screen: float = GameplayContainerServiceNode.end.y
	var height_quadrant: float = height_screen / 4
	var height_offset: float = height_quadrant / 2
	var pos: Positions = MobPositionServiceNode.get_horizontal_positions("left", height_offset)
	
	tween.tween_callback(func():
		mob_spawner.spawn_mob_explode(pos)
	)
	tween.tween_interval(1.5)
	tween.tween_callback(func():
		pos = MobPositionServiceNode.get_horizontal_positions("rigth", height_quadrant + height_offset)
		mob_spawner.spawn_mob_explode(pos)
	)
	tween.tween_interval(3.0)
	tween.tween_callback(func():
		pos = MobPositionServiceNode.get_horizontal_positions("left", (3 * height_quadrant) + height_offset)
		mob_spawner.spawn_mob_explode(pos)
	)
	tween.tween_interval(1.5)
	tween.tween_callback(func():
		pos = MobPositionServiceNode.get_horizontal_positions("rigth", (2 * height_quadrant) + height_offset)
		mob_spawner.spawn_mob_explode(pos)
	)
	
	tween.tween_callback(func():
		end_event.emit()
	).set_delay(5.0)
