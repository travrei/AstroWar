extends Enemies

@export_category("Suicide Enemy Properties")
@export var time_to_attack: float = 1.0
@export var attack_speed: float = 800.0
@export_category("Nodes")
@export var animatesprite: AnimatedSprite2D = AnimatedSprite2D.new()

var player_node: CharacterBody2D = null

func initial() -> void:
	var start_pos: Vector2 = global_position
	var target_x_mid = start_pos.x + 160
	var target_y_bottom = start_pos.y + 192
	var target_y_mid = start_pos.y + 92

	var tween: Tween = create_tween()
	tween.tween_property(self, "global_position:x", target_x_mid, 1.0).set_trans(tween.TRANS_LINEAR)
	tween.tween_property(self, "global_position:y", target_y_bottom, 1.0).set_trans(tween.TRANS_LINEAR)
	tween.tween_property(self, "global_position:y", target_y_mid, 0.3).set_trans(tween.TRANS_LINEAR)

	await tween.finished

	await get_tree().create_timer(time_to_attack).timeout
	if !is_dead:
		attack()

func attack() -> void:
	if player_node == null:
		push_error("Player not Found!")

	var player_pos: Vector2 = player_node.global_position
	var direction: Vector2 = (player_pos - global_position).normalized()
	var fly_distance: float = 3000.0
	var target_pos = global_position + direction * fly_distance

	var duration = fly_distance / attack_speed

	var tween: Tween = create_tween()

	tween.tween_property(self, "global_position", target_pos, duration).set_trans(tween.TRANS_LINEAR)
	tween.tween_callback(queue_free)


func _ready() -> void:
	player_node = get_tree().get_first_node_in_group("Player")
	initial()


func _on_area_entered(area: Area2D) -> void:
	death()
	animatesprite.animation = "explosion"

func _on_body_entered(body: Node2D) -> void:
	body.death()

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
