class_name MobEventSecond
extends MobEvent


func fire(mob_spawner, player, tween) -> void:
	var count = 3
	
	# 1º primeira seção (mais fácil)
	while count > 0:
		tween.tween_callback(func():
			mob_spawner.spawn_mob_flash(MobPositionServiceNode.get_vertical_random_position(), player))
		tween.tween_interval(1.0)
		count -= 1
	
	tween.tween_interval(1.5)
	count = 3
	
	# 2º seção (mais dificil)
	while count > 0:
		tween.tween_callback(func():
			mob_spawner.spawn_mob_flash(MobPositionServiceNode.get_vertical_random_position(), player)
			mob_spawner.spawn_mob_flash(MobPositionServiceNode.get_horizontal_random_position(), player))
		tween.tween_interval(1.0)
		count -= 1
	
	tween.tween_callback(func():
		end_event.emit()
	)
