extends Area2D

@export_category("Properties SuicideSpawnArea")
@export var how_many_spawns: int = 1
@export_category("Nodes")
@export var suicide_scene: PackedScene


func _on_body_entered(body: Node2D) -> void:
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)

	for i in range(how_many_spawns):
		var suicide = suicide_scene.instantiate()
		get_tree().root.add_child(suicide)
		await get_tree().create_timer(1).timeout
