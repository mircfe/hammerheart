extends Node2D
@onready var door_exit: Area2D = $DoorExit
@onready var player: CharacterBody2D = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	door_exit.open_door.connect(_on_player_exit)

func _on_player_exit() -> void:
	print("Nexl level...")
	player.exit_door = true
	player._set_anim("door_in")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
