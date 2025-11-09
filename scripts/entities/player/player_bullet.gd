extends Area2D

#Imports
@onready var bullet_1: Sprite2D = $Bullet1
@onready var bullet_2: Sprite2D = $Bullet2
@onready var bullet_3: Sprite2D = $Bullet3
@onready var bulletlast: Sprite2D = $Bulletlast
@onready var bulletlast_2: Sprite2D = $Bulletlast2
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

#Variables
@export_category("Bullet Properties")
@export var speed: int = 200
const BULLET_1 = preload("uid://cbu05yae1u1s2")
const BULLET_2 = preload("uid://csiv50r1w0hra")
var bullet_lv = PlayerLevel.Level.LV0

func _process(delta: float) -> void:
	moviment(delta)
	match_player_lv()

func moviment(delta: float) -> void:
	position.y -= speed * delta

func match_player_lv() -> void:
	match bullet_lv:
		PlayerLevel.Level.LV0:
			collision_shape_2d.set_shape(BULLET_1)
			bullet_1.visible = true
		PlayerLevel.Level.LV1:
			collision_shape_2d.set_shape(BULLET_2)
			bullet_1.visible = true
			bullet_2.visible = true
			bullet_3.visible = true
		PlayerLevel.Level.LV2:
			bullet_1.visible = false
			bullet_2.visible = false
			bullet_3.visible = false
			bulletlast.visible = true
			bulletlast_2.visible = true


func _exit_screen() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if bullet_lv == PlayerLevel.Level.LV2:
		return
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if bullet_lv == PlayerLevel.Level.LV2:
		return
	queue_free()
