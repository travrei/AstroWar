extends Enemies

@export_category("Nodes")
@export var bullet_scene: PackedScene
@export var detection_area: Area2D
@export var animatedsprite: AnimatedSprite2D

@export_category("Properties")
@export var time_to_leave: float = 1.5
@export var explosion_fx: AudioStreamPlayer2D

var target_player = null

func _on_detect_player_body_entered(body: Node2D) -> void:
	target_player = body
	shoot_at_player()

func shoot_at_player() -> void:
	if target_player == null:
		return

	var bullet = bullet_scene.instantiate()
	bullet.position = position

	var direction: Vector2 = (target_player.global_position - global_position).normalized()

	bullet.rotation = direction.angle()

	get_parent().add_child(bullet)
	await get_tree().create_timer(time_to_leave).timeout
	exit_screen()

func exit_screen() -> void:
	var tween: Tween = create_tween()

	tween.tween_property(self, "global_position:x", global_position.x - 320, 1.0).set_trans(tween.TRANS_LINEAR)
	tween.tween_callback(queue_free)

func _on_body_entered(body: Node2D) -> void:
	body.death()

func _on_area_entered(_area: Area2D) -> void:
	if !is_dead:
		explosion_fx.play()
	death()
	animatedsprite.animation = "explosion"

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
