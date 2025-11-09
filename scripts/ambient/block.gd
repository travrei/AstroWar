extends Area2D

@onready var sprite: AnimatedSprite2D = $Sprite

const blocks: Array = ["quadrado", "trapezio", "tetrino"]
const SCOREINDICATOR = preload("uid://bxcm4fp4d6eey")

@export var score_giver: int = 5
var is_exploded: bool = false
func _ready() -> void:
	var animation = blocks.pick_random()

	sprite.animation = animation

func _on_area_entered(area: Area2D) -> void:
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	is_exploded = true
	sprite.animation = "explosion"

func display_score():
	var score_indicator = SCOREINDICATOR.instantiate()
	score_indicator.amount = score_giver
	score_indicator.position = global_position
	get_tree().root.add_child(score_indicator)

func _on_sprite_animation_finished() -> void:
	if is_exploded:
		display_score()
		Global.add_score(score_giver)
		queue_free()
