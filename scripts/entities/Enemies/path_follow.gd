extends PathFollow2D

@export_category("PathFollowEnemy Properties")
@export var score_giver: int = 1
@export var speed: float = 0.002
@export var animationsprite: AnimatedSprite2D = AnimatedSprite2D.new()

const SCOREINDICATOR = preload("uid://bxcm4fp4d6eey")

func _process(delta: float) -> void:
	progress_ratio += speed

func display_score():
	var score_indicator = SCOREINDICATOR.instantiate()
	score_indicator.amount = score_giver
	score_indicator.position = global_position
	get_tree().root.add_child(score_indicator)

func _on_hit_area_body_entered(body: Node2D) -> void:
	body.death()

func _on_hit_area_area_entered(area: Area2D) -> void:
	display_score()
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	Global.add_score(score_giver)
	scale = Vector2(0.8, 0.8)
	animationsprite.animation = "explosion"

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
