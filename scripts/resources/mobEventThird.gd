class_name MobEventThird
extends MobEvent


func fire(mob_spawner, mob_spawn_pos, _player, tween) -> void:
	tween.tween_callback(func():
		mob_spawner.spawn_mob_obstacle(mob_spawn_pos.get_horizontal_random_position())
		mob_spawner.spawn_mob_obstacle(mob_spawn_pos.get_horizontal_random_position()))
	tween.tween_interval(1.0)
	tween.tween_callback(func():
		mob_spawner.spawn_mob_obstacle(mob_spawn_pos.get_horizontal_random_position())
		mob_spawner.spawn_mob_obstacle(mob_spawn_pos.get_horizontal_random_position()))
	tween.tween_interval(1.0)
	tween.tween_callback(func():
		mob_spawner.spawn_mob_obstacle(mob_spawn_pos.get_horizontal_random_position())
		mob_spawner.spawn_mob_obstacle(mob_spawn_pos.get_horizontal_random_position()))
	tween.tween_interval(1.0)
	tween.tween_callback(func():
		mob_spawner.spawn_mob_obstacle(mob_spawn_pos.get_horizontal_random_position())
		mob_spawner.spawn_mob_obstacle(mob_spawn_pos.get_horizontal_random_position()))
	tween.tween_interval(8.0)
	tween.tween_callback(func():
		end_event.emit()
	)
