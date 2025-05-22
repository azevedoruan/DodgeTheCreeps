extends Node
class_name Hud

signal start_game

@onready var hud_pivot = $Pivot
@onready var debug_log: Control = $Pivot/DebugLog
@onready var developer_control: Control = $DeveloperControl
@onready var statistics = $Pivot/DebugLog/Statistics
@onready var time_label = $Pivot/TimeLabel


func _ready():
	var hud_size = Vector2(get_tree().root.content_scale_size)
	var screen_size = Vector2(DisplayServer.screen_get_size())
	var safe_area_size = Vector2(DisplayServer.get_display_safe_area().size)
	var safe_area_pos = Vector2(DisplayServer.get_display_safe_area().position)
	
	# calcula a posição e tamanho do HUD proporcionalmente ao tamanho da tela do
	# dispositivo levando em consideração a safe area (area sem sobreposição do "notch")
	var new_hud_pos = (safe_area_pos / screen_size) * hud_size
	var new_hud_size = (safe_area_size * hud_size) / screen_size
	
	hud_pivot.set_position(new_hud_pos)
	hud_pivot.set_size(new_hud_size)
	
	#TEST for dev configurations
	debug_log.hide()
	developer_control.hide()
	MyUtility.print_message_log("root size: " + str(get_tree().root.size))
	MyUtility.print_message_log("viewport size: " + str(get_viewport().size))
	MyUtility.print_message_log("window size: " + str(get_window().size))
	MyUtility.print_message_log("content scale size: " + str(get_tree().root.content_scale_size))
	MyUtility.print_message_log("window scaled size: " + str(MyUtility.get_window_scaled()))


func _process(_delta):
	var viewport_size = get_tree().root.size
	statistics.clear()
	statistics.add_text("Viewport size: %dx%d\n\n" % [viewport_size.x, viewport_size.y])
	statistics.add_text("FPS: %d\n" % Performance.get_monitor(Performance.TIME_FPS))
	statistics.add_text("CPU time: %.5f\n" % Performance.get_monitor(Performance.TIME_PROCESS))
	statistics.add_text("Node count: %d\n" % Performance.get_monitor(Performance.OBJECT_NODE_COUNT))
	var player_pos: Vector2 = get_parent().player.position
	statistics.add_text("player pos: %.1f, %.1f\n" % [player_pos.x, player_pos.y])


func show_message(text):
	$Pivot/Message.text = text
	$Pivot/Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	
	await $MessageTimer.timeout
	
	$Pivot/Message.text = "Dodge the\nCreeps!"
	$Pivot/Message.show()
	
	await  get_tree().create_timer(1.0).timeout
	
	$Pivot/StartButton.show()


func update_time(time: float) -> void:
	var mil: float = fmod(time, 1) * 1000
	var sec: float = fmod(time, 60)
	var _min: float = fmod(time, 60*60) / 60
	var time_str: String = "%02d:%02d:%03d" % [_min, sec, mil]
	time_label.text = time_str


func update_score(score):
	$Pivot/ScoreLabel.text = str(score)


func _on_message_timer_timeout():
	$Pivot/Message.hide()


func _on_start_button_pressed():
	$Pivot/StartButton.hide()
	start_game.emit()

#TEST for dev configurations
func _on_stats_button_down():
	if !debug_log.visible:
		debug_log.show()
		developer_control.show()
		set_process(true)
	else:
		debug_log.hide()
		developer_control.hide()
		set_process(false)

#TEST for dev configurations
func _on_imortal_mode_button_toggled(toggled_on: bool) -> void:
	get_parent().player.is_immortal = toggled_on
	if toggled_on:
		MyUtility.print_message_log("player is immortal")
	else:
		MyUtility.print_message_log("player can be die")

#TEST for dev configurations
func _on_time_accelerate_button_toggled(toggled_on: bool) -> void:
	get_parent().time_scale(toggled_on)

#TEST for dev configurations
func _on_event_1_button_pressed() -> void:
	get_parent().fire_event_test(0)

#TEST for dev configurations
func _on_event_1_button_2_pressed() -> void:
	get_parent().fire_event_test(1)

#TEST for dev configurations
func _on_event_1_button_3_pressed() -> void:
	get_parent().fire_event_test(2)

#TEST for dev configurations
func _on_event_1_button_4_pressed() -> void:
	get_parent().fire_event_test(3)

#TEST for dev configurations
func _on_event_1_button_5_pressed():
	get_parent().fire_event_test(4)

#TEST for dev configurations
func _on_event_1_button_6_pressed():
	get_parent().fire_event_test(5)

#TEST for dev configurations
func _on_draw_line_debug_button_pressed() -> void:
	get_parent().activate_rect_lines_debug()
