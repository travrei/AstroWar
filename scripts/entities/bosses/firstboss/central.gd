extends Area2D

signal central_died

@export_category("Central Properties")
@export var rotation_speed: float = 4.0
@export var num_bullets: int = 12
@export var num_hits: int = 8

@export_category("Nodes")
@export var bullet_scene: PackedScene
@export var shoot_timer: Timer
@export var hit_sound: AudioStreamPlayer2D

var current_angle: float = 0.0
var can_shoot: bool = false
var wave_offset: float
var max_offset_limit: float = 0.3
var wave_direction: int = 1

func start_shooting() -> void:
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)
	can_shoot = true
	shoot_timer.start()

func _process(delta: float) -> void:
	if !can_shoot:
		return

	current_angle += rotation_speed * delta

func spawn_bullets() -> void:
	if !can_shoot:
		return

	var start_angle = 0.0
	var arc_lenght = PI

	for i in range(num_bullets):
		var bullet = bullet_scene.instantiate()

		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position

		var progress = float(i) / float(num_bullets - 1)

		var final_angle = start_angle + (progress * arc_lenght)

		bullet.rotation = final_angle + wave_offset

	shoot_timer.start()

	wave_offset += 0.1 * wave_direction
	if wave_offset > max_offset_limit:
		wave_offset = max_offset_limit
		wave_direction = -1
	elif wave_offset < max_offset_limit:
		wave_offset = -max_offset_limit
		wave_direction = 1


func _on_area_entered(_area: Area2D) -> void:
	num_hits -= 1
	hit_sound.play()

	if num_hits <= 0:
		emit_signal("central_died")
		queue_free()
