extends Node
class_name Hud

signal start_game
signal pause_game(paused: bool)

#TEST for dev configurations
@onready var statistics = $Pivot/DebugLog/Statistics


func _ready():
	_init_pivot_setup()
	_print_statistics()
	$Pivot/Menu.show()
	$Pivot/Gameplay.hide()
	$Pivot/GameOver.disappears()
	$Pivot/GameOver.hide()
	$Pivot/Menu/version.text = ProjectSettings.get_setting("application/config/version")
	

# calcula a posição e tamanho do HUD proporcionalmente ao tamanho da tela do
# dispositivo levando em consideração a safe area (area sem sobreposição do "notch")
func _init_pivot_setup() -> void:
	var hud_size = Vector2(get_tree().root.content_scale_size)
	var screen_size = Vector2(DisplayServer.screen_get_size())
	var safe_area_size = Vector2(DisplayServer.get_display_safe_area().size)
	var safe_area_pos = Vector2(DisplayServer.get_display_safe_area().position)
	var new_hud_pos = (safe_area_pos / screen_size) * hud_size
	var new_hud_size = (safe_area_size * hud_size) / screen_size
	$Pivot.set_position(new_hud_pos)
	$Pivot.set_size(new_hud_size)


#TEST for dev configurations
func _print_statistics() -> void:
	$Pivot/DebugLog.hide()
	$DeveloperControl.hide()
	MyUtility.print_message_log("root size: " + str(get_tree().root.size))
	MyUtility.print_message_log("viewport size: " + str(get_viewport().size))
	MyUtility.print_message_log("window size: " + str(get_window().size))
	MyUtility.print_message_log("content scale size: " + str(get_tree().root.content_scale_size))


func _process(_delta):
	var viewport_size = get_tree().root.size
	statistics.clear()
	statistics.add_text("Viewport size: %dx%d\n\n" % [viewport_size.x, viewport_size.y])
	statistics.add_text("FPS: %d\n" % Performance.get_monitor(Performance.TIME_FPS))
	statistics.add_text("CPU time: %.5f\n" % Performance.get_monitor(Performance.TIME_PROCESS))
	statistics.add_text("Node count: %d\n" % Performance.get_monitor(Performance.OBJECT_NODE_COUNT))
	var player_pos: Vector2 = get_parent().player.position
	statistics.add_text("player pos: %.1f, %.1f\n" % [player_pos.x, player_pos.y])

# TODO mudar o chamador
func show_start_message(text: String, time: float = 2.0):
	var msg: RichTextLabel = $Pivot/Gameplay/MessageStart
	msg.set_text("[center][shake rate=20.0 level=5 connected=1] %s [/shake][/center]" % text)
	msg.show()
	await get_tree().create_timer(time).timeout
	msg.hide()


func show_game_over(score: int):
	$Pivot/Gameplay.hide()
	$Pivot/GameOver.show()
	await $Pivot/GameOver.appears(score)
	$Pivot/GameOver.disappears()
	$Pivot/GameOver.hide()
	$Pivot/Menu.show()


func update_score(score):
	$Pivot/Gameplay/ScoreLabel.text = str(score)


func _on_start_button_start_game():
	$Pivot/GameOver.disappears()
	$Pivot/Menu.hide()
	$Pivot/Gameplay.show()
	start_game.emit()


func _on_button_pause():
	$Pivot/Gameplay.hide()
	$Pivot/Pause.show()
	pause_game.emit(true)


func _on_button_resume():
	$Pivot/Gameplay.show()
	$Pivot/Pause.hide()
	pause_game.emit(false)


#TEST for dev configurations
func _on_stats_button_down():
	if !$Pivot/DebugLog.visible:
		$Pivot/DebugLog.show()
		$DeveloperControl.show()
		set_process(true)
	else:
		$Pivot/DebugLog.hide()
		$DeveloperControl.hide()
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
