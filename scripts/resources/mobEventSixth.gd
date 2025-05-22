class_name MobEventSixth
extends MobEvent

func fire(mob_spawner: MobSpawner, _player: Player, tween: Tween) -> void:
	# superior esquerdo
	var pos: Positions = MobPositionServiceNode.get_vertical_positions("top", GameplayContainerServiceNode.get_top_left_corner().x + 50)
	var dir: float = 90
	_spawn_sequence(mob_spawner, tween, pos, dir)
	
	# inferior direito
	pos = MobPositionServiceNode.get_vertical_positions("bottom", GameplayContainerServiceNode.get_bottom_rigth_corner().x - 50)
	dir = 270
	var tween_parallel: Tween = mob_spawner.get_tree().create_tween()
	_spawn_sequence(mob_spawner, tween_parallel, pos, dir)
	
	# inferior esquerdo
	pos = MobPositionServiceNode.get_horizontal_positions("left", GameplayContainerServiceNode.get_bottom_left_corner().y - 50)
	dir = 0
	_spawn_sequence(mob_spawner, tween, pos, dir)
	
	# superior direito
	pos = MobPositionServiceNode.get_horizontal_positions("right", GameplayContainerServiceNode.get_top_rigth_corner().y + 50)
	dir = 180
	_spawn_sequence(mob_spawner, tween_parallel, pos, dir)
	
	tween.tween_interval(2.5)
	tween.tween_callback(func():
		end_event.emit()
	)


func _spawn_sequence(mob_spawner: MobSpawner, tween: Tween, pos: Positions, direction: float) -> void:
	var i: int = 0
	while i < 5:
		tween.tween_callback(func():
			mob_spawner.spawn_mob_common(pos, direction, Vector2(130, 0), "walk")
		)
		tween.tween_interval(0.75)
		direction -= 15
		i += 1
