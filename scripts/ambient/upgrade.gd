extends Area2D

func _process(delta: float) -> void:
	position.y += 1

func _on_body_entered(body: Node2D) -> void:
	body.upgrade_up_one()
	queue_free()
