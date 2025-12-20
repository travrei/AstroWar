extends Control

@onready var ScoreLabel: Label = $VBoxContainer/ScoreLabel
@onready var ResetLabel: Label = $VBoxContainer/HBox/RestLabel
@onready var SepLabel: Label = $VBoxContainer/HBox/sepLabel
@onready var QuitLabel: Label = $VBoxContainer/HBox/QuitLabel

func _ready() -> void:
	ScoreLabel.text = "Score: " + str(Global.player_score)

	await get_tree().create_timer(2).timeout

	ResetLabel.visible = true
	SepLabel.visible = true
	QuitLabel.visible = true

func _unhandled_input(event: InputEvent) -> void:
	await get_tree().create_timer(2).timeout
	
	if event.is_action_pressed("Shoot"):
		queue_free()
		get_viewport().set_input_as_handled()

		#Reseting Score
		Global.player_score = 0

		get_tree().reload_current_scene()
