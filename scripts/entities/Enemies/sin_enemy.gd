extends Enemies

@export_category("Sin_Wave_Properties")
@export var amplitude: int = 50
@export var velocity: int = 2

@export_category("Nodes")
@export var animatesprite: AnimatedSprite2D = AnimatedSprite2D.new()
@export var explosion_fx: AudioStreamPlayer2D

var start_x: float
var passed_time: float = 0.0


func _ready() -> void:
	start_x = position.x

func _process(delta: float) -> void:
	if !is_dead:
		passed_time += delta
		var sin_wave = sin(passed_time * velocity)
		position.x = start_x + (sin_wave * amplitude)


func _on_body_entered(body: Node2D) -> void:
	body.death()

func _on_area_entered(area: Area2D) -> void:
	if !is_dead:
		explosion_fx.play()
	death()
	animatesprite.animation = "explosion"

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
