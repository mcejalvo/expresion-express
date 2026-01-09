extends Node

var words_file_path : String = "res://data/words.txt"
var last_word = ""
var words : Array = []
var status : GameStatus = GameStatus.PAUSED
var timer : Timer = Timer.new()
const TIMER_DURATION : int = 45
signal game_started
signal game_ended
signal passed_word

enum GameStatus {
	PAUSED,
	RUNNING
}

enum SkipStatus {
	AVAILABLE,
	MAX_REACHED
}

func _start_timer() -> void: 
	timer.set_wait_time(TIMER_DURATION)
	timer.one_shot = true 
	timer.start()
	print("Timer started")
	
func _timer_ended() -> void:
	print("Timer ended") 
	toggle_status()
	
func start_game() -> void:
	status = GameStatus.RUNNING
	_start_timer()
	game_started.emit()

		
	
func pause_game() -> void: 
	status = GameStatus.PAUSED
	timer.stop()
	game_ended.emit()
	
	
func toggle_status() -> void:
	if status == GameStatus.PAUSED:
		start_game()
	elif status == GameStatus.RUNNING:
		pause_game()
		
	print("Game is %s" % GameStatus.keys()[status])
		
func load_csv(file_path : String) -> Array:
	var file = FileAccess.open(file_path, FileAccess.READ)

	if file == null:
		printerr("No se pudo cargar el archivo con las palabras.")

	while not file.eof_reached():
		var line = file.get_line()
		if !line.is_empty():
			words.append(line)

	file.close()
	return words

func pick_word() -> String:
	passed_word.emit()
	var selected_word = words.pick_random()
	while selected_word == last_word:
		selected_word = words.pick_random()
	print("Selected word: %s" % selected_word)
	last_word = selected_word
	

	return selected_word

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	words = load_csv(words_file_path)
	add_child(timer)
	timer.timeout.connect(_timer_ended)
