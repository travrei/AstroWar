extends Area2D

@export_category("First Boss Properties")
@export var speed: float = 200
@export_category("Nodes")
@export var central: Area2D

var player_node: CharacterBody2D = null
var count_turrets: int = 0

func _ready() -> void:
	player_node = get_tree().get_first_node_in_group("Player")
	count_turrets = get_tree().get_node_count_in_group("boss_turrets")

func _physics_process(delta: float) -> void:
	position.x = move_toward(position.x, player_node.global_position.x, speed * delta)


func phase2() -> void:
	central.start_shooting()


func _on_boss_torrent_turret_died() -> void:
	count_turrets -= 1

	if count_turrets <= 0:
		phase2()


func _on_central_central_died() -> void:
	var tween = create_tween()
	tween.parallel().tween_property(self, "modulate:a", 0.0, 3.0).set_trans(tween.TRANS_SINE)
	tween.parallel().tween_property(self, "scale:x", 0.0, 3.0).set_trans(tween.TRANS_SINE)
	tween.parallel().tween_property(self, "scale:y", 0.0, 3.0).set_trans(tween.TRANS_SINE)

	var player = get_tree().get_first_node_in_group("Player")
	player.victory_routine()

	tween.tween_callback(queue_free)
