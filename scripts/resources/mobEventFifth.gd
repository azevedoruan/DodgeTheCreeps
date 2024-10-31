class_name MobEventFifth
extends MobEvent

func fire(mob_spawner: MobSpawner, mob_spawn_pos: MobSpawnPositionHandler, player, tween: Tween) -> void:
	var heigth_screen: float = MyUtility.get_window_scaled().y
	var heigth_quadrant: float = heigth_screen / 4
	var heigth_offset: float = heigth_quadrant / 2
	var pos: Positions = mob_spawn_pos.get_horizontal_positions("left", heigth_offset)
	
	tween.tween_callback(func():
		mob_spawner.spawn_mob_explode(pos)
	)
	tween.tween_interval(1.5)
	tween.tween_callback(func():
		pos = mob_spawn_pos.get_horizontal_positions("rigth", heigth_quadrant + heigth_offset)
		mob_spawner.spawn_mob_explode(pos)
	)
	tween.tween_interval(3.0)
	tween.tween_callback(func():
		pos = mob_spawn_pos.get_horizontal_positions("left", (3 * heigth_quadrant) + heigth_offset)
		mob_spawner.spawn_mob_explode(pos)
	)
	tween.tween_interval(1.5)
	tween.tween_callback(func():
		pos = mob_spawn_pos.get_horizontal_positions("rigth", (2 * heigth_quadrant) + heigth_offset)
		mob_spawner.spawn_mob_explode(pos)
	)
	
	tween.tween_callback(func():
		end_event.emit()
	).set_delay(5.0)
