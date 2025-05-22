class_name Main
extends Node

@onready var player: Player = $Container/Player
@onready var mob_spawner: MobSpawner = $MobSpawner
@onready var mobs_event_handler: MobsEventHandler = $MobsEventHandler
@onready var hud: Hud = $HUD
@onready var mob_timer: Timer = $MobTimer
@onready var special_mobs_timer: Timer = $SpecialMobsTimer
@onready var event_timer: Timer = $EventTimer
@onready var start_position: Marker2D = $Container/StartPosition
@onready var bubble_handler: BubbleHandler = $Container/BubbleHandler

var mob_timer_decrementer: int = 20
var time_on: bool
var time: float
var score: int = 0
var special_mob_count: int = 0
var event_count: int = 0

#TEST for dev configurations
var is_time_scaled: bool = false


func _ready() -> void:
	mobs_event_handler.end_event_handler.connect(_on_mobs_event_end)
	GameplayContainerServiceNode.init_container_position()
	MobPositionServiceNode.init_positions()


func _process(delta):
	if time_on:
		time += delta
		hud.update_time(time)
	
	if Input.is_action_just_pressed("time_scale"):
		if is_time_scaled == false:
			time_scale(true)
		else:
			time_scale(false)	


#TEST for dev configurations
func time_scale(toggle: bool) -> void:
	if toggle:
		Engine.set_time_scale(3.0)
		MyUtility.print_message_log("time scale 3.0")
	else:
		Engine.set_time_scale(1.0)
		MyUtility.print_message_log("time scale 1.0")
	is_time_scaled = toggle


func on_bubble_collected() -> void:
	score += 1
	hud.update_score(score)


func _game_over() -> void:
	mob_timer.stop()
	special_mobs_timer.stop()
	event_timer.stop()
	time_on = false
	hud.show_game_over()
	$Music.stop()
	$DeathSound.play()


func new_game():
	get_tree().call_group("mobs", "queue_free")
	time = 0
	score = 0
	special_mob_count = 0
	mob_timer_decrementer = 20
	event_count = 0
	mob_timer.wait_time = 2
	special_mobs_timer.wait_time = 1
	player.start(start_position.position)
	$StartTimer.start()
	hud.update_score(score)
	hud.update_time(time)
	hud.show_message("Get Ready")
	$Music.play()
	MyUtility.print_message_log("Game Started!")
	bubble_handler.reset_bubbles()
	mobs_event_handler.restart_events()

#TEST for dev configurations
func fire_event_test(index: int) -> void:
	mobs_event_handler.fire_a_event(mob_spawner, player, index)

#TEST for dev configurations
func activate_rect_lines_debug() -> void:
	var obj: LinesDebug2D = $Container/GameplayBorder
	obj.is_debug = !obj.is_debug
	obj.queue_redraw()


func _on_start_timer_timeout():
	mob_timer.start()
	special_mobs_timer.start()
	event_timer.start()
	time_on = true


# spawna os mobs na cena
func _on_mob_timer_timeout():
	# decrementa o tempo de espera para o próximo spawn dos mobs
	if time >= mob_timer_decrementer and time < 85:
		mob_timer.wait_time -= 0.375
		mob_timer_decrementer += 20
	
	# mobs comuns abaixo de 10 pontos
	if time < 10:
		mob_spawner.spawn_random_mob_common(MobPositionServiceNode.get_vertical_random_position(), player)
		return
	
	# mobs comuns acima de 10 pontos
	if randf() < 0.5:
		mob_spawner.spawn_random_mob_common(MobPositionServiceNode.get_horizontal_random_position(), player)
	else:
		mob_spawner.spawn_random_mob_common(MobPositionServiceNode.get_vertical_random_position(), player)


func _on_mobs_event_start() -> void:
	special_mobs_timer.stop()
	mob_timer.stop()
	event_timer.stop()
	var tween: Tween = get_tree().create_tween()
	tween.tween_interval(7.0)
	tween.tween_callback(func():
		mobs_event_handler.fire_event(mob_spawner, player)
	)
	MyUtility.print_message_log("Tempo de evento")


func _on_mobs_event_end() -> void:
	if player.visible == false:
		return
	
	special_mobs_timer.start()
	mob_timer.start()
	event_timer.start()
	MyUtility.print_message_log("event end")


func _on_special_mobs_timer_timeout() -> void:
	special_mob_count += 1
	
	if (special_mob_count % 12) == 0 and time > 20:
		mob_spawner.spawn_mob_flash(MobPositionServiceNode.get_vertical_random_position(), player)
	
	if (special_mob_count % 10) == 0 and time > 60:
		mob_spawner.spawn_mob_follower(MobPositionServiceNode.get_vertical_random_position(), player)
	
	if (special_mob_count % 8) == 0 and time > 90:
		mob_spawner.spawn_mob_obstacle(MobPositionServiceNode.get_horizontal_random_position())
	
	if (special_mob_count % 14) == 0 and time > 125:
		mob_spawner.spawn_mob_explode(MobPositionServiceNode.get_horizontal_random_position())
