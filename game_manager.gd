extends Node

signal gems_changed(value: int)
signal hearts_changed(value : int)
signal open_chest(value: bool)

var current_gems = 0
var total_hearts = 3
var is_chest_open = false
var key = false

func add_gem() -> void:
	current_gems+=1
	gems_changed.emit(current_gems)
	if current_gems == 5:
		open_chest.emit(true)
		

func remove_hearts() -> void:
	total_hearts-=1
	hearts_changed.emit(total_hearts)
	
func add_hearts() -> void:
	if total_hearts<3:
		total_hearts+=1
		hearts_changed.emit(total_hearts)

func get_hearts() -> int:
	return total_hearts

func reset_gems() -> void:
	current_gems = 0

func have_key() ->bool:
	return key

func get_key() -> void:
	key = true
