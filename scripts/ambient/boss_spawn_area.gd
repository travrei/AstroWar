extends Area2D

@export_category("Properties BossSpawnArea")
@export_category("Nodes")
@export var boss_scene: PackedScene
@export var map: Node2D
@export var bg_music: AudioStreamPlayer
@export var boss_msc: AudioStreamOggVorbis

func _on_body_entered(body: Node2D) -> void:
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)

	var boss = boss_scene.instantiate()
	map.should_scroll = false
	boss.global_position = Vector2(-20 , 0)
	get_tree().root.add_child(boss)
	bg_music.stream = boss_msc
	bg_music.pitch_scale = 1.3
	bg_music.play()
