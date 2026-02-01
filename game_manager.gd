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

func reset_hearts() -> void:
	total_hearts = 3
	
func have_key() ->bool:
	return key

func get_key() -> void:
	key = true


	
func start_game_over_sequence() -> void:
	#Quando avviamo la sequenza di game over perchè il player è morto disabilitiamo il PROCESS MODE dei cannoni come prima cosa
	for c in get_tree().get_nodes_in_group("Cannons"):
		c.process_mode = Node.PROCESS_MODE_DISABLED
		
	# 2) Aspetta animazione morte (2 secondi circa)
	await get_tree().create_timer(2.0).timeout
	
	# 3) Pausa gioco e mostra GameOverPanel
	get_tree().paused = true
	
	var game_over_panel = get_tree().get_first_node_in_group("GameOverPanel")
	if game_over_panel:
		game_over_panel.visible = true
		game_over_panel.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	else:
		print("❌ ERRORE: GameOverPanel non trovato!")

func next_level_sequence() -> void:
	#Quando avviamo la sequenza di game over perchè il player è morto disabilitiamo il PROCESS MODE dei cannoni come prima cosa
	for c in get_tree().get_nodes_in_group("Cannons"):
		c.process_mode = Node.PROCESS_MODE_DISABLED
		
	# 2) Aspetta animazione morte (2 secondi circa)
	await get_tree().create_timer(2.0).timeout
	
	# 3) Pausa gioco e mostra GameOverPanel
	get_tree().paused = true
	
	var next_level_panel = get_tree().get_first_node_in_group("NextLevelPanel")
	if next_level_panel:
		next_level_panel.visible = true
		next_level_panel.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	else:
		print("❌ ERRORE: NextLevelPanel non trovato!")
