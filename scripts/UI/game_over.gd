extends Control

@onready var ScoreLabel: Label = $VBoxContainer/ScoreLabel
@onready var ResetLabel: Label = $VBoxContainer/HBox/RestLabel
@onready var SepLabel: Label = $VBoxContainer/HBox/sepLabel
@onready var QuitLabel: Label = $VBoxContainer/HBox/QuitLabel

const MENU = preload("uid://368oh7vd8o8f")
var can_restart: bool = false

func _ready() -> void:
	ScoreLabel.text = "Score: " + str(Global.player_score)

	await get_tree().create_timer(2).timeout

	ResetLabel.visible = true
	SepLabel.visible = true
	QuitLabel.visible = true
	
	await get_tree().create_timer(1).timeout
	can_restart = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot") and can_restart:
		queue_free()
		get_viewport().set_input_as_handled()

		#Reseting Score
		Global.player_score = 0

		get_tree().reload_current_scene()
	
	elif event.is_action_pressed("ui_cancel") and can_restart:
		queue_free()
		get_tree().change_scene_to_packed(MENU)
