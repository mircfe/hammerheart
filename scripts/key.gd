extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var key: Area2D = $"."
@onready var sfx: AudioStreamPlayer2D = $Sfx
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	key.visible = false
	GameManager.open_chest.connect(_on_open_chest)

func _on_open_chest(value : bool) -> void:
	if value:
		key.visible = true
		animated_sprite_2d.play("rotate")
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		collision_shape_2d.disabled = true
		print("Chiave presa...")
		GameManager.get_key()
		key.visible = false
		
		sfx.play()

func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
