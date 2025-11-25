extends Area2D

@export_category("Properties BossSpawnArea")
@export_category("Nodes")
@export var boss_scene: PackedScene
@export var map: Node2D

func _on_body_entered(body: Node2D) -> void:
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)

	var boss = boss_scene.instantiate()
	map.should_scroll = false
	boss.global_position = Vector2(320 / 2, 32)
	get_tree().root.add_child(boss)
