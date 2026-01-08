extends Control

@onready var CongratsLabel: Label = $VBoxContainer/Label
@onready var ScoreLabel: Label = $VBoxContainer/ScoreLabel
const MENU = preload("uid://368oh7vd8o8f")

func _ready() -> void:
	ScoreLabel.text = "Score: " + str(Global.player_score + 200)

	await get_tree().create_timer(10).timeout

	CongratsLabel.text = "Thank You For Playing!"
	ScoreLabel.text = "More coming soon!"

	await get_tree().create_timer(10).timeout
	
	get_tree().change_scene_to_packed(MENU)
