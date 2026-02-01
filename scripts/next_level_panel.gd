extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_continue_pressed() -> void:
	get_tree().paused = false
	GameManager.reset_gems()
	GameManager.reset_hearts()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
