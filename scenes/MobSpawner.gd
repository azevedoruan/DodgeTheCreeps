extends Node
class_name MobSpawner

@export var shadow: PackedScene
@export var shadow_duration: float = 1.2
@export var mob_common: PackedScene
@export var mob_flash: PackedScene
@export var mob_follower: PackedScene


func spawn_random_common_mob(positions: Positions, player: Player) -> void:
	var mob_instance: MobCommon = mob_common.instantiate() as MobCommon
	mob_instance.set_default_behaviour(positions.mob_position, player)
	_spawn_mob(mob_instance, positions.shadow_positon)


func spawn_mob_common(positions: Positions, direction: float, velocity: Vector2, animation_name: String) -> void:
	var mob_instance: MobCommon = mob_common.instantiate() as MobCommon
	mob_instance.set_position(positions.mob_position)
	mob_instance.set_rotation(direction)
	mob_instance.set_animation_name(animation_name)
	mob_instance.set_velocity(velocity)
	_spawn_mob(mob_instance, positions.shadow_positon)


func spawn_mob_flash(positions: Positions, direction_point: Vector2) -> void:
	var mob_instance: Node2D = mob_flash.instantiate() as Node2D
	mob_instance.set_position(positions.mob_position)
	mob_instance.set_rotation(positions.mob_position.angle_to_point(direction_point))
	_spawn_mob(mob_instance, positions.shadow_positon)


func spawn_mob_follower(positions: Positions, player: Player) -> void:
	var mob_instance = mob_follower.instantiate()
	mob_instance.set_position(positions.mob_position)
	mob_instance.set_current_direction(positions.mob_position.angle_to_point(player.position))
	mob_instance.set_player(player)
	_spawn_mob(mob_instance, positions.shadow_positon)


func _spawn_mob(instance: Node2D, shadow_position: Vector2) -> void:
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
