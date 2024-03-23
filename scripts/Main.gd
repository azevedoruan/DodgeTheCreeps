extends Node
class_name Main

@onready var player: Player = $Player
@onready var mob_spawner: MobSpawner = $MobSpawner
@onready var mob_spawn_position_handler: MobSpawnPositionHandler = $MobSpawnPositionHandler

@export var mob_timer_decrescent_time: int = 10

var score: int = 0
var spawn_count: int = 0
var event_count: int = 0
var is_time_scaled: bool = false

func _process(_delta):
	if Input.is_action_just_pressed("time_scale"):
		if is_time_scaled == false:
			Engine.set_time_scale(3.0)
			print("time scale 3.0")
			is_time_scaled = true
		else:
			Engine.set_time_scale(1.0)
			print("time scale 1.0")
			is_time_scaled = false


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()


func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	spawn_count = 0
	mob_timer_decrescent_time = 10
	event_count = 0
	$MobTimer.wait_time = 2
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


# spawna os mobs na cena
func _on_mob_timer_timeout():
	spawn_count += 1
	
	# decrementa o tempo de espera para o próximo spawn dos mobs
	if score >= mob_timer_decrescent_time and score < 80:
		$MobTimer.wait_time -= 0.375
		mob_timer_decrescent_time += 20
	
	# mobs comuns abaixo de 10 pontos
	if score < 10:
		mob_spawner.spawn_random_mob_common(mob_spawn_position_handler.get_vertical_random_position(), player)
		return
	
	# mob flash a partir de 20 pontos e 9 spawns
	if spawn_count > 8 and (spawn_count % 9) == 0:
		mob_spawner.spawn_mob_flash(mob_spawn_position_handler.get_vertical_random_position(), player.position)
		return
	
	# mob follower a partir 40 pontos e 28 spawns
	if spawn_count > 27 and (spawn_count % 7) == 0:
		mob_spawner.spawn_mob_follower(mob_spawn_position_handler.get_vertical_random_position(), player)
		return
	
	# mob obstacle a partir de 60 pontos e 40 spawns
	if spawn_count > 39 and (spawn_count % 5) == 0:
		mob_spawner.spawn_mob_obstacle(mob_spawn_position_handler.get_horizontal_random_position())
		return
	
	# mob explode a partir de 70 pontos e 55 spawns
	if spawn_count > 54 and (spawn_count % 11) == 0:
		mob_spawner.spawn_mob_explode(mob_spawn_position_handler.get_horizontal_random_position())
		return
	
	# eventos a partir de 80 pontos e 77 spawns
	if spawn_count > 92 and (spawn_count % 31) == 0:
		$MobTimer.stop()
		print("tempo de evento")
		var tween: Tween = get_tree().create_tween()
		tween.tween_interval(7.0)
		tween.tween_callback(start_events)
	
	# mobs comuns acima de 10 pontos
	if randf() < 0.5:
		mob_spawner.spawn_random_mob_common(mob_spawn_position_handler.get_horizontal_random_position(), player)
	else:
		mob_spawner.spawn_random_mob_common(mob_spawn_position_handler.get_vertical_random_position(), player)


func start_events() -> void:
	event_count += 1
	var event_index = 0
	
	if event_count <= 5:
		event_index = event_count
	else:
		event_index = randi_range(1, 5)
	
	match event_index:
		1:
			first_event()
		2:
			second_event()
		3:
			third_event()
		4:
			fourth_event()
		5:
			fifth_event()


func first_event() -> void:
	print("inicia primeiro evento")
	var tween: Tween = get_tree().create_tween()
	tween.tween_callback(func():
		var positions: Positions = mob_spawn_position_handler.get_horizontal_positions("left", 30)
		mob_spawner.spawn_mob_common(positions, 0, Vector2(130, 0), "walk")
		positions.set_y(150)
		mob_spawner.spawn_mob_common(positions, 0, Vector2(130, 0), "walk")
		positions.set_y(270)
		mob_spawner.spawn_mob_common(positions, 0, Vector2(130, 0), "walk")
		positions.set_y(390)
		mob_spawner.spawn_mob_common(positions, 0, Vector2(130, 0), "walk")
		
		positions = mob_spawn_position_handler.get_horizontal_positions("right", 330)
		mob_spawner.spawn_mob_common(positions, 180, Vector2(130, 0), "walk")
		positions.set_y(450)
		mob_spawner.spawn_mob_common(positions, 180, Vector2(130, 0), "walk")
		positions.set_y(570)
		mob_spawner.spawn_mob_common(positions, 180, Vector2(130, 0), "walk")
		positions.set_y(690)
		mob_spawner.spawn_mob_common(positions, 180, Vector2(130, 0), "walk"))
	tween.tween_interval(5.0)
	tween.tween_callback(func(): $MobTimer.start())


func second_event() -> void:
	var count = 3
	var tween: Tween = get_tree().create_tween()
	
	# 1º primeira seção (mais fácil)
	while count > 0:
		tween.tween_callback(func(): mob_spawner.spawn_mob_flash(mob_spawn_position_handler.get_vertical_random_position(), player.position))
		tween.tween_interval(1.0)
		count -= 1
	
	tween.tween_interval(1.5)
	count = 3
	
	# 2º seção (mais dificil)
	while count > 0:
		tween.tween_callback(func():
			mob_spawner.spawn_mob_flash(mob_spawn_position_handler.get_vertical_random_position(), player.position)
			mob_spawner.spawn_mob_flash(mob_spawn_position_handler.get_horizontal_random_position(), player.position))
		tween.tween_interval(1.0)
		count -= 1
	
	tween.tween_callback(func(): $MobTimer.start())


func third_event() -> void:
	var tween: Tween = get_tree().create_tween()
	#tween.tween_callback(func():
	#	$MobSpawnerHandler.spawn_custom_horizontal(mob_obstacle, "left", 105, 0)
	#	$MobSpawnerHandler.spawn_custom_horizontal(mob_obstacle, "left", 355, 0)
	#	$MobSpawnerHandler.spawn_custom_horizontal(mob_obstacle, "left", 605, 0))
	tween.tween_interval(5.0)
	tween.tween_callback(func(): $MobTimer.start())


func fourth_event() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_callback(func(): print("inicia quarto evento"))
	tween.tween_interval(5.0)
	tween.tween_callback(func(): $MobTimer.start())


func fifth_event() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_callback(func(): print("inicia quinto evento"))
	tween.tween_interval(5.0)
	tween.tween_callback(func(): $MobTimer.start())
