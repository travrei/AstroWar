extends Control

@export_category("Cenes")
@export var first_level: PackedScene

func _on_start_b_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)

func _on_exit_b_pressed() -> void:
	get_tree().quit()
