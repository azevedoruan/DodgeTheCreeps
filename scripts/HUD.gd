extends Node

signal start_game

@onready var hud_pivot = $Pivot
@onready var statistics = $Pivot/Statistics

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

func _process(delta):
	var viewport_size = get_tree().root.size
	statistics.clear()
	statistics.add_text("Viewport size: %dx%d\n\n" % [viewport_size.x, viewport_size.y])
	statistics.add_text("FPS: %d\n" % Performance.get_monitor(Performance.TIME_FPS))
	statistics.add_text("CPU time: %.5f\n" % Performance.get_monitor(Performance.TIME_PROCESS))
	statistics.add_text("Node count: %d\n" % Performance.get_monitor(Performance.OBJECT_NODE_COUNT))

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

func update_score(score):
	$Pivot/ScoreLabel.text = str(score)

func _on_message_timer_timeout():
	$Pivot/Message.hide()

func _on_start_button_pressed():
	$Pivot/StartButton.hide()
	start_game.emit()

func _on_stats_button_down():
	if !statistics.visible:
		statistics.show()
		set_process(true)
	else:
		statistics.hide()
		set_process(false)
