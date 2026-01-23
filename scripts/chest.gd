extends StaticBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.open_chest.connect(_on_open_chest)
	animated_sprite_2d.play("idle")

func _on_open_chest(value : bool) -> void:
	if value:
		animated_sprite_2d.play("open")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
