extends CharacterBody2D

class_name Player

#signals
signal player_death

#Imports
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var shooting_marker: Marker2D = $ShootingMarker
@onready var collision: CollisionShape2D = $CollisionShape2D

#Variables
@export_category("Player Properties")
@export var player_lv = PlayerLevel.Level.LV0
@export var speed = 300.0
@export_category("Nodes")
@export var bullet_scene: PackedScene
@export var assistent_scene: PackedScene
@export_category("Sounds")
@export var shooting_sound: AudioStreamPlayer2D
@export var shooting_sound_lv3: AudioStreamPlayer2D
@export var upgrade_sound: AudioStreamPlayer2D
@export var death_sound: AudioStreamPlayer2D

var is_dead: bool = false
var in_cutscene: bool = false
var upgrade: int = 0
var direction: Vector2 = Vector2.ZERO
var numb_of_assistent = 0

func _physics_process(delta: float) -> void:
	if !is_dead and !in_cutscene:
		moviment(delta)
		change_player_sprite()

		if Input.is_action_just_pressed("Shoot"):
			shoot()
			match_shoot_sound()
	else:
		death_sound.pitch_scale -= 0.001
		if death_sound.pitch_scale <= 0.50:
			death_sound.pitch_scale = 0.50

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

func match_shoot_sound() -> void:
	match player_lv:
		PlayerLevel.Level.LV0:
			shooting_sound.play()
		PlayerLevel.Level.LV1:
			shooting_sound.play()
		PlayerLevel.Level.LV2:
			shooting_sound_lv3.play()

func change_player_sprite() -> void:
	match player_lv:
		PlayerLevel.Level.LV0:
			sprite.animation = "LV0"
		PlayerLevel.Level.LV1:
			sprite.animation = "LV1"
		PlayerLevel.Level.LV2:
			sprite.animation = "LV2"

func death() -> void:
	sprite.animation = "explosion"
	if !is_dead:
		death_sound.play()
	is_dead = true
	set_deferred("collision_layer", 1)
	emit_signal("player_death")

func _on_sprite_animation_finished() -> void:
	if is_dead:
		death_sound.stop()

func upgrade_up_one() -> void:
	upgrade += 1
	upgrade_sound.play()
	match upgrade:
		2: player_lv = PlayerLevel.Level.LV1
		4: player_lv = PlayerLevel.Level.LV2
		6: spawn_assistent()
		8: spawn_assistent()
		_: return

func spawn_assistent() -> void:
	numb_of_assistent += 1
	var assistent = assistent_scene.instantiate()
	assistent.player_to_follow = self
	assistent.global_position = self.global_position
	assistent.fixed_distance = assistent.fixed_distance * numb_of_assistent
	get_parent().add_child(assistent)

func victory_routine() -> void:
	in_cutscene = true
	velocity = Vector2.ZERO
	collision.set_deferred("disabled", true)

	var center_pos = get_viewport_rect().size / 2
	var t1 = create_tween()
	t1.parallel().tween_property(self, "global_position:x", center_pos.x, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	t1.parallel().tween_property(self, "global_position:y", 150, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	await get_tree().create_timer(10).timeout

	var t2 = create_tween()
	t2.parallel().tween_property(self, "global_position:y", -200, 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	t2.parallel().tween_property(self, "scale", Vector2(0.5, 3.0), 0.5)
