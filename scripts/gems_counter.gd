extends CanvasLayer

@onready var gems_label: Label = $Control/GemsLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.gems_changed.connect(_on_gems_changed)

func _on_gems_changed(value: int) -> void:
	gems_label.text = str("Gems: " + str(value))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
