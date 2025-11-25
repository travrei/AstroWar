extends Node2D

@export var should_scroll: bool = true

func _process(delta: float) -> void:
	if should_scroll:
		position.y += 0.5
