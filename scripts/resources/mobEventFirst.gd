class_name MobEventFirst
extends MobEvent


func fire(mob_spawner, _player, tween) -> void:
	tween.tween_callback(func():
		# primeira onda
		var center: int = int(GameplayContainerServiceNode.center.y)
		
		# parede de mobs lado esquerdo
		var left_positions: Positions = MobPositionServiceNode.get_horizontal_positions("left", center + 30)
		while left_positions.mob_position.y > GameplayContainerServiceNode.begin.y:
			mob_spawner.spawn_mob_common(left_positions, 0, Vector2(130, 0), "walk")
			left_positions.set_y(left_positions.mob_position.y - 120)
		
		# parede de mobs lado direito
		var rigth_positions = MobPositionServiceNode.get_horizontal_positions("rigth", center - 30)
		while rigth_positions.mob_position.y < GameplayContainerServiceNode.end.y:
			mob_spawner.spawn_mob_common(rigth_positions, 180, Vector2(130, 0), "walk")
			rigth_positions.set_y(rigth_positions.mob_position.y + 120)
	)
	tween.tween_interval(3.8)
	tween.tween_callback(func():
		# segunda onda
		var center: int = int(GameplayContainerServiceNode.center.y)
		
		# parede de mobs lado esquerdo
		var left_positions: Positions = MobPositionServiceNode.get_horizontal_positions("rigth", center + 150)
		while left_positions.mob_position.y > GameplayContainerServiceNode.begin.y:
			mob_spawner.spawn_mob_common(left_positions, 180, Vector2(130, 0), "walk")
			left_positions.set_y(left_positions.mob_position.y - 120)
		
		# parede de mobs lado direito
		var rigth_positions = MobPositionServiceNode.get_horizontal_positions("left", center - 150)
		while rigth_positions.mob_position.y < GameplayContainerServiceNode.end.y:
			mob_spawner.spawn_mob_common(rigth_positions, 0, Vector2(130, 0), "walk")
			rigth_positions.set_y(rigth_positions.mob_position.y + 120)
	)
	tween.tween_interval(5.0)
	tween.tween_callback(func():
		end_event.emit()
	)
