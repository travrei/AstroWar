extends PathFollow2D

@export_category("PathFollowEnemy Properties")
@export var score_giver: int = 1
@export var speed: float = 0.002

func _process(delta: float) -> void:
	progress_ratio += speed

func _on_hit_area_body_entered(body: Node2D) -> void:
	body.death()

func _on_hit_area_area_entered(area: Area2D) -> void:
	Global.add_score(score_giver)
	queue_free()
