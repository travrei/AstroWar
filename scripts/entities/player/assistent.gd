extends Node2D

var player_to_follow: Node2D = null

@export_category("Assistent Properties")
@export var fixed_distance: int = 100
@export var follow_speed: int = 10
@export var bullet_scene: PackedScene = PackedScene.new()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		shoot()

	follow_player(delta)

func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.bullet_lv = PlayerLevel.Level.LV2
	bullet.position = global_position
	get_tree().root.add_child(bullet)

func follow_player(delta: float) -> void:
	var player_pos = player_to_follow.global_position
	var my_pos = global_position

	var direction_from_player = (my_pos - player_pos).normalized()

	if direction_from_player == Vector2.ZERO:
		direction_from_player = Vector2.RIGHT

	var target_pos = player_pos + (direction_from_player * fixed_distance)

	global_position = global_position.lerp(target_pos, follow_speed * delta)
