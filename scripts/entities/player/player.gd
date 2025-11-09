extends CharacterBody2D

class_name Player

#Imports
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var shooting_marker: Marker2D = $ShootingMarker

#Variables
@export_category("Player Properties")
@export var player_lv = PlayerLevel.Level.LV0
@export var speed = 300.0
@export var bullet_scene: PackedScene = PackedScene.new()
var is_dead: bool = false
var upgrade: int = 0
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if !is_dead:
		moviment(delta)
		change_player_sprite()
		level_up()
		
		if Input.is_action_just_pressed("Shoot"):
			shoot()

	print(Global.player_score)

func moviment(delta: float) -> void:
	direction.x = Input.get_axis("Left", "Right")
	direction.y = Input.get_axis("Up", "Down")
	#Keep The same velocity on diagonal
	direction.normalized()

	velocity = direction * speed * delta

	move_and_slide()


func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.bullet_lv = player_lv
	bullet.position = shooting_marker.global_position
	get_tree().root.add_child(bullet)

func change_player_sprite() -> void:
	match player_lv:
		PlayerLevel.Level.LV0:
			sprite.animation = "LV0"
		PlayerLevel.Level.LV1:
			sprite.animation = "LV1"
		PlayerLevel.Level.LV2:
			sprite.animation = "LV2"

func death() -> void:
	is_dead = true
	sprite.animation = "explosion"


func _on_sprite_animation_finished() -> void:
	if is_dead:
		print("Game OVER!")

func upgrade_up_one():
	upgrade += 1
	
func level_up():
	match upgrade:
		2: player_lv = PlayerLevel.Level.LV1
		4: player_lv = PlayerLevel.Level.LV2
		6: pass #spawn assistent
		8: pass #spawn assistent
		_: return
