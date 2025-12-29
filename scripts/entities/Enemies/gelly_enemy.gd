extends Enemies

@export_category("Gelly Properties")
@export var speed: int = 20
@export_category("Nodes")
@export var animatesprite: AnimatedSprite2D = AnimatedSprite2D.new()
@export var explosion_fx: AudioStreamPlayer2D

var direction: Vector2 = Vector2.ZERO
var can_move: bool = false

func _ready() -> void:
	direction.x = randf_range(-0.5, 0.5)
	direction.y = 1.0

func _process(delta: float) -> void:
	moviment(delta)

func moviment(delta) -> void:
	if !is_dead && can_move:
		direction.normalized()
		global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	body.death()

func _on_area_entered(_area: Area2D) -> void:
	if !is_dead:
		explosion_fx.play()
	death()
	animatesprite.animation = "explosion"

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	can_move = true
