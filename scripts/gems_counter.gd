extends CanvasLayer

@onready var gems_label: Label = $Control/GemsLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gems_changed.connect(_refresh_gems)
	GameManager.environment_changed.connect(_refresh_gems)
	

func _refresh_gems(_value: int = -1) -> void:
	gems_label.text = "Gems: %d/%d" % [GameManager.current_gems, GameManager.total_gems]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
