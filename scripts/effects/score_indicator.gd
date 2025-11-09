extends Node2D

@onready var score_label: Label = $ScoreLabel

@export var amount: int = 0

func _ready() -> void:
	score_label.text = str(amount)
	animate()


func animate() -> void:
	var tween: Tween = create_tween()

	tween.tween_property(self, "position:y", global_position.y - 30, 0.8).set_trans(tween.TRANS_SINE)
	tween.tween_property(self, "modulate:a", 0, 0.3).set_delay(0.5)
	tween.tween_callback(queue_free)
