class_name GameOverHud
extends Control

const INITIAL_POS_MESSAGE: float = 335.5 

@export var decrement_time_score_count: Curve

@onready var message: Label = $GameOverMessage
@onready var score_panel: Control = $ScorePanel
@onready var score_label: Label = $ScorePanel/ScoreLabel
@onready var best_label: Label = $ScorePanel/BestLabel
@onready var new_label: RichTextLabel = $ScorePanel/NewText
@onready var particles: GPUParticles2D = $ScorePanel/GPUParticles2D

func _ready() -> void:
	disappears()


func appears(score: int) -> void:
	var best: int = int(MyUtility.load_variable())
	score_label.set_text(str(0))
	best_label.set_text(str(best))
	message.show()
	var t: Tween = get_tree().create_tween()
	t.tween_interval(1.0)
	t.tween_property(message, "position", Vector2(0, 250), 0.25)
	t.tween_callback(func(): score_panel.show()).set_delay(0.25)
	await t.tween_interval(0.25).finished
	
	var time_counter: float = 0.1
	for i in range(score):
		score_label.set_text(str(i+1))
		await get_tree().create_timer(time_counter).timeout
		time_counter -= decrement_time_score_count.sample(time_counter)
	
	if score > best:
		time_counter = 0.1
		for i in range(score - best):
			best_label.set_text(str(i+1+best))
			await get_tree().create_timer(time_counter).timeout
			time_counter -= decrement_time_score_count.sample(time_counter)
		
		best = score
		new_label.show()#TODO NEW label animation FX
		particles.show()
		particles.emitting = true
		MyUtility.save_variable(str(best))
	
	await get_tree().create_timer(0.5).timeout


func disappears() -> void:
	message.position.y = INITIAL_POS_MESSAGE
	message.hide()
	score_panel.hide()
	new_label.hide()
	particles.hide()
