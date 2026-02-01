extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_open_door: AudioStreamPlayer2D = $SfxOpenDoor

signal open_door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and GameManager.have_key():
		#Blocca il controllo del movimento del Player che verrà guidato dall'animazione della porta
		body.can_move = false
		animated_sprite_2d.play("opening")
		sfx_open_door.play()


func _on_sfx_open_door_finished() -> void:
	open_door.emit()
