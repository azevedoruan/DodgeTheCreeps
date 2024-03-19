extends Node
class_name MobSpawner

@export var shadow: PackedScene
@export var shadow_duration: float = 1.2


func spawn_mob(instance: Node2D, shadow_position: Vector2) -> void:
	# instance shadow
	var shadow_instance = shadow.instantiate()
	shadow_instance.set_position(shadow_position)
	get_parent().add_child(shadow_instance)
	
	# shadow animation
	var tween = get_tree().create_tween()
	tween.tween_property(shadow_instance, "modulate", Color(0.0, 0.0, 0.0, 0.5), shadow_duration)
	tween.tween_callback(shadow_instance.queue_free)
	
	# instance mob
	tween.tween_callback(func(): get_parent().add_child(instance))
