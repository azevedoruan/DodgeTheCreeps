extends Node2D

class_name Explosion

func _ready():
	$GPUParticles2D.emitting = true
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.5)
	tween.tween_callback(func(): queue_free())

func _on_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
