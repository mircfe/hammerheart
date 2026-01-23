extends CanvasLayer

@onready var hearts := [
	$Control/HeartsLayer/Heart1,
	$Control/HeartsLayer/Heart2,
	$Control/HeartsLayer/Heart3,
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.hearts_changed.connect(_on_hearts_changed)

func _on_hearts_changed(value: int) -> void:
	set_health(value)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_health(hp: int) -> void:
	for i in range(3):
		hearts[i].visible = i < hp
