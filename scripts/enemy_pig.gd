extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var collision_shape_2d_detec_area: CollisionShape2D = $DetectionArea/CollisionShape2D

#Il player è nel raggio d'azione del nemico?
var player_in_range:bool = false
var is_dead:bool = false

func _ready() -> void:
	animated_sprite_2d.play("idle")
	

func take_damage() -> void:
	if is_dead:
		return
	is_dead = true
	collision_shape_2d.disabled = true
	collision_shape_2d_detec_area.disabled = true
	#sfx_explosion.play()
	animated_sprite_2d.play("die")


func _on_detection_area_body_entered(body: Node2D) -> void:
	if (body.name == "Player" and is_dead==false):
		player_in_range = true
		animated_sprite_2d.play("attack")
	

func _on_detection_area_body_exited(body: Node2D) -> void:
	if (body.name == "Player" and is_dead==false):
		player_in_range = false
		animated_sprite_2d.play("idle")


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation=="die":
		queue_free()
