extends Area2D

class_name Enemies

const SCOREINDICATOR = preload("uid://bxcm4fp4d6eey")
const EXPLOSIONDEATH: AudioStreamWAV = preload("uid://4co4oi46xjkk")

@export_category("Enemy Variables")
@export var score_giver: int = 1

var is_dead: bool = false

func display_score() -> void:
	var score_indicator = SCOREINDICATOR.instantiate()
	score_indicator.amount = score_giver
	score_indicator.position = global_position
	get_tree().root.add_child(score_indicator)

func death() -> void:
	is_dead = true
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	display_score()
	Global.add_score(score_giver)
