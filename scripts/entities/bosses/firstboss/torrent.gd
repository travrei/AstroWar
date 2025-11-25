extends Area2D

signal turret_died

@export_category("Nodes")
@export var bullet_scene: PackedScene
@export var timer_node: Timer
@export var hit_sound: AudioStreamPlayer2D

@export_category("Boss Torrent Properties")
@export var life: int = 5
@export var invicibility_time: float = 0.7

var player_node = null
var can_take_damage: bool = true

func _ready() -> void:
	player_node = get_tree().get_first_node_in_group("Player")
	timer_node.start()

func shoot_at_player() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position

	var direction: Vector2 = (player_node.global_position - global_position).normalized()
	bullet.rotation = direction.angle()
	get_parent().get_tree().root.add_child(bullet)
	timer_node.start()


func _on_shoot_timer_timeout() -> void:
	shoot_at_player()

func _on_area_entered(area: Area2D) -> void:
	if !can_take_damage:
		return

	life -= 1
	hit_sound.play()
	if life <= 0:
		emit_signal("turret_died")
		queue_free()
	else:
		inv_animation()


func inv_animation() -> void:
	can_take_damage = false
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.6, 0.1).set_trans(tween.TRANS_SINE)

	await get_tree().create_timer(invicibility_time).timeout

	var return_tween = create_tween()

	return_tween.tween_property(self, "modulate:a", 1.0, 0.1)
	can_take_damage = true
