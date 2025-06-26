# script feito seguindo o tutorial https://www.youtube.com/watch?v=yDto2FnJipI
# Pelo Mostly Mad Productions

class_name AnimationButton
extends Button

signal start_game

@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var pressed_scale: Vector2 = Vector2(0.9, 0.9)

const INITIAL_SCALE: Vector2 = Vector2.ONE
const ANIMATION_TIME: float = 0.1

func _ready() -> void:
	mouse_entered.connect(_button_enter)
	mouse_exited.connect(_button_exit)
	pressed.connect(_button_pressed)
	visibility_changed.connect(_reset_scale)
	call_deferred("_init_pivot")


func _init_pivot() -> void:
	pivot_offset = size/2.0


func _button_enter() -> void:
	create_tween().tween_property(self, "scale", hover_scale, ANIMATION_TIME).set_trans(Tween.TRANS_SINE)


func _button_exit() -> void:
	create_tween().tween_property(self, "scale", INITIAL_SCALE, ANIMATION_TIME).set_trans(Tween.TRANS_SINE)


func _button_pressed() -> void:
	var t: Tween = create_tween()
	t.tween_property(self, "scale", pressed_scale, 0.03).set_trans(Tween.TRANS_SINE)
	t.tween_property(self, "scale", hover_scale, 0.06).set_trans(Tween.TRANS_SINE)
	t.tween_callback(func(): start_game.emit())


func _reset_scale() -> void:
	set_scale(INITIAL_SCALE)
