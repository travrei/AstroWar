extends Area2D

@export_category("EnemyBullet Properties")
@export var speed: int = 400

func _process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)

	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	body.death()
