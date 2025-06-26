class_name GameOverHud
extends Control

const INITIAL_POS_MESSAGE: float = 335.5 

@onready var message: Label = $GameOverMessage
@onready var score_panel: Control = $ScorePanel
@onready var score_label: Label = $ScorePanel/VBoxContainerScores/ScoreLabel
@onready var best_label: Label = $ScorePanel/VBoxContainerScores/BestLabel

func _ready() -> void:
	disappears()


func appears(score: int, best: int) -> Signal:
	message.show()
	var t: Tween = get_tree().create_tween()
	t.tween_interval(1.0)
	t.tween_property(message, "position", Vector2(0, 250), 0.25)
	t.tween_callback(func(): score_panel.show()).set_delay(0.25)
	score_label.set_text(str(score))
	best_label.set_text(str(best))
	return t.tween_interval(1.0).finished


func disappears() -> void:
	message.position.y = INITIAL_POS_MESSAGE
	message.hide()
	score_panel.hide()
