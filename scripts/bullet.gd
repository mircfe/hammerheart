extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var bullet_speed = 100.0
var direction = Vector2.LEFT
# Indica se il player è stato colpito
var hit_player = false
# Riferimento al player per distruggerlo se colpito
var ref_player
# Indica se il bullet è stato colpito o ha colliso con qualcosa
var is_hit = false

@onready var sfx: AudioStreamPlayer2D = $Sfx

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_hit:
		global_position += direction * bullet_speed * delta

func explosion() -> void:
	pass
	#animated_sprite_2d.play("explosion")

func explosion_sound() -> void:
	sfx.play()

func bullet_hit() -> void:
	is_hit = true
	collision_shape_2d.disabled = true
	sfx.play()
	#hide()
	animated_sprite_2d.play("explosion")
	
func _on_body_entered(body: Node2D) -> void:
	bullet_hit()
	if body.name == "Player":
		print("Collisione bullet <-> player")
		hit_player = true
		ref_player = body
	else:
		print("Collisione bullet <-> altro")
		


func _on_sfx_finished() -> void:
	if hit_player:
		hit_player = false
		GameManager.remove_hearts()
		if GameManager.get_hearts()==0:
			ref_player.die()
		queue_free()
	else:
		queue_free()
