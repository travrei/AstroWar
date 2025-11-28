extends Node2D

class_name Map

@export var should_scroll: bool = true
@export var backgroundmusic: AudioStreamPlayer
@export var game_over_scene: PackedScene

const game_over_msc: AudioStreamOggVorbis = preload("uid://dhn201mgj44h8")

func _process(delta: float) -> void:
	if should_scroll:
		position.y += 0.5

func _on_player_player_death() -> void:
	var game_over = game_over_scene.instantiate()
	get_tree().root.add_child(game_over)

	should_scroll = false
	backgroundmusic.stream = game_over_msc
	backgroundmusic.pitch_scale = 1
	backgroundmusic.play()
