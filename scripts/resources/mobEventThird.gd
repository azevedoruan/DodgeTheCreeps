class_name MobEventThird
extends MobEvent


func fire(mob_spawner, _player, tween) -> void:
	tween.tween_callback(func():
		mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position())
		mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position()))
	tween.tween_interval(1.0)
	tween.tween_callback(func():
		mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position())
		mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position()))
	tween.tween_interval(1.0)
	tween.tween_callback(func():
		mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position())
		mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position()))
	tween.tween_interval(1.0)
	tween.tween_callback(func():
		mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position())
		mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position()))
	tween.tween_interval(8.0)
	tween.tween_callback(func():
		end_event.emit()
	)
