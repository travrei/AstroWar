extends Marker2D

@export_category("SpawnerUpgrade Properties")
@export var upgrade_scene: PackedScene = PackedScene.new()


func _ready():
	Global.score_updated.connect(spawn_upgrade)

func spawn_upgrade(score):
	if score > 0 && score % 20 == 0:
		var upgrade_obj = upgrade_scene.instantiate()
		upgrade_obj.position = global_position
		get_tree().root.add_child(upgrade_obj)
