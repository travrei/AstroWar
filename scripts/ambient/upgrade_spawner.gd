extends Marker2D

@export_category("SpawnerUpgrade Properties")
@export var upgrade_scene: PackedScene = PackedScene.new()
@export var next_spawn_target: int = 20

func _ready() -> void:
	Global.score_updated.connect(check_spawn)

func check_spawn(current_score: int) -> void:
	while current_score >= next_spawn_target:
		spawn_upgrade()

		next_spawn_target += 20

func spawn_upgrade() -> void:
	var upgrade_obj = upgrade_scene.instantiate()
	upgrade_obj.position = global_position
	get_tree().root.add_child(upgrade_obj)
