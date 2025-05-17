class_name MobEventFourth
extends MobEvent


func fire(mob_spawner: MobSpawner, player, tween: Tween) -> void:
	# meio da tela vertical
	var mid_screen_y: float = MyUtility.get_window_scaled().y / 2
	var mid_screen_x: float = MyUtility.get_window_scaled().x / 2
	
	tween.tween_callback(func():
		var pos: Positions = MobPositionServiceNode.get_horizontal_positions("left", mid_screen_y)
		mob_spawner.spawn_mob_follower(pos, player)
		
		pos = MobPositionServiceNode.get_horizontal_positions("rigth", mid_screen_y)
		mob_spawner.spawn_mob_follower(pos, player)
		
		pos = MobPositionServiceNode.get_vertical_positions("top", mid_screen_x)
		mob_spawner.spawn_mob_follower(pos, player)
		
		pos = MobPositionServiceNode.get_vertical_positions("bottom", mid_screen_x)
		mob_spawner.spawn_mob_follower(pos, player)
	)
	
	tween.tween_callback(func():
		end_event.emit()
	).set_delay(5.0)
