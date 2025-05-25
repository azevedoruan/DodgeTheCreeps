class_name MobEventThird
extends MobEvent

# Original behaviour
#func fire(mob_spawner, _player, tween) -> void:
	#tween.tween_callback(func():
		#mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position())
		#mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position()))
	#tween.tween_interval(1.0)
	#tween.tween_callback(func():
		#mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position())
		#mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position()))
	#tween.tween_interval(1.0)
	#tween.tween_callback(func():
		#mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position())
		#mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position()))
	#tween.tween_interval(1.0)
	#tween.tween_callback(func():
		#mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position())
		#mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position()))
	#tween.tween_interval(8.0)
	#tween.tween_callback(func():
		#end_event.emit()
	#)

func fire(mob_spawner: MobSpawner, player: Player, tween: Tween) -> void:
	# primeiro
	tween.tween_callback(func():
		var pos: Positions = MobPositionServiceNode.get_horizontal_positions("left", 220.0)
		pos.mob_position.x -= 110.0
		mob_spawner.spawn_mob_obstacle(pos)
	)
	tween.tween_interval(5.0)
	# segundo
	tween.tween_callback(func():
		var pos: Positions = MobPositionServiceNode.get_horizontal_positions("rigth", 560.0)
		pos.mob_position.x += 110.0
		mob_spawner.spawn_mob_obstacle(pos)
	)
	tween.tween_interval(5.0)
	tween.tween_callback(func():
		end_event.emit()
	)
