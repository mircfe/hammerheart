extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_hammer: AudioStreamPlayer2D = $SfxHammer
@onready var hitbox: Area2D = $Hitbox


const SPEED := 130.0
const JUMP_VELOCITY := -400.0
var is_attacking := false
var hitbox_offset_left:= Vector2(-35,4)
var hitbox_offset_right:= Vector2(25,4)

func _ready() -> void:
	animated_sprite_2d.animation_finished.connect(_on_anim_finished)
	animated_sprite_2d.animation_looped.connect(_on_anim_looped) # safety
	hitbox.position = hitbox_offset_right
	
func die() -> void:
	GameManager.reset_gems()
	queue_free()
	get_tree().call_deferred("reload_current_scene")
	
func _physics_process(delta: float) -> void:
	# Disabilita la hitbox dell'attacco sino a quando il player non fa un attacco premendo SPACE
	hitbox.monitoring = false
	
	# Gravità
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Movimento orizzontale
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED if direction != 0.0 else move_toward(velocity.x, 0, SPEED)

	# Salto
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Flip
	if direction > 0: 
		animated_sprite_2d.flip_h = false
		update_hitbox_offset()
	elif direction < 0: 
		animated_sprite_2d.flip_h = true
		update_hitbox_offset()

	# Attacco (anche in aria)
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()

	move_and_slide()

	# Animazioni (non sovrascrivere l'attacco)
	if is_attacking:
		return

	if not is_on_floor():
		_set_anim("jump")
	elif abs(direction) < 0.01:
		_set_anim("idle")
	else:
		_set_anim("run")

func attack() -> void:
	is_attacking = true
	hitbox.monitoring = true
	sfx_hammer.play()
	_set_anim("attack")
	
func _set_anim(name: String) -> void:
	if animated_sprite_2d.animation != name:
		animated_sprite_2d.play(name)

func _on_anim_finished() -> void:
	if animated_sprite_2d.animation == "attack":
		is_attacking = false

func _on_anim_looped() -> void:
	# Se per errore attack è in loop, evita il soft-lock.
	if animated_sprite_2d.animation == "attack":
		is_attacking = false

func update_hitbox_offset() -> void:
	if animated_sprite_2d.flip_h:
		hitbox.position = hitbox_offset_left
	else:
		hitbox.position = hitbox_offset_right


func _on_hitbox_body_entered(body: Node2D) -> void:
	if is_attacking and body.is_in_group("Cannons"):
		print("Hit cannon")
		body.cannon_hit()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if is_attacking and area.is_in_group("Bullets"):
		print("Hit bullet...")
		area.bullet_hit()
