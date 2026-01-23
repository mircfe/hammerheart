extends StaticBody2D
@onready var cannon_sprite_animation: AnimatedSprite2D = $CannonSpriteAnimation
@onready var muzzle: Marker2D = $Muzzle
@onready var shoot_timer: Timer = $ShootTimer
@onready var sfx: AudioStreamPlayer2D = $Sfx
@onready var sfx_explosion: AudioStreamPlayer2D = $SfxExplosion
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var bullet_scene = preload("res://scenes/bullet.tscn")
var rng := RandomNumberGenerator.new()
@export var min_shot_time := 2.0
@export var max_shot_time := 5.0

# Indica se il cannone è stato colpito dal martello del player
var is_hit = false

func shoot() -> void:
	var new_bullet = bullet_scene.instantiate()
	new_bullet.add_to_group("Bullets")
	new_bullet.global_position = muzzle.global_position
	get_parent().add_child(new_bullet)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cannon_sprite_animation.play("idle")
	rng.randomize()
	shoot_timer.start(rng.randf_range(min_shot_time,max_shot_time))


func cannon_hit() -> void:
	shoot_timer.stop()
	sfx.stop()
	is_hit = true
	collision_shape_2d.disabled = true
	sfx_explosion.play()
	cannon_sprite_animation.play("explosion")
	
func _on_timer_timeout() -> void:
	cannon_sprite_animation.play("shoot")
	sfx.play()
	shoot()
	shoot_timer.start(rng.randf_range(min_shot_time,max_shot_time))

func _on_cannon_sprite_animation_animation_finished() -> void:
	if cannon_sprite_animation.animation=="shoot":
		print("Shoot finish")
		cannon_sprite_animation.play("idle")


func _on_sfx_explosion_finished() -> void:
	queue_free()
