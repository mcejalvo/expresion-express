extends AudioStreamPlayer

var beep: AudioStream = preload("res://assets/sound/beep.wav")
var timer_end: AudioStream = preload("res://assets/sound/beep_end.wav")

@warning_ignore("integer_division")
var timer_windows: Array = [GameManager.TIMER_DURATION * 3/9, GameManager.TIMER_DURATION * 6/9, GameManager.TIMER_DURATION - 1]
var beep_distance_seconds: Array = [0.4, 0.2, 0.15, 0.1]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.game_started.connect(_on_game_started)
	GameManager.game_ended.connect(_on_game_ended)
	stream = beep
	print("Timer Duration %f, 1:%fs, 2:%fs, 3:%fs" % [GameManager.TIMER_DURATION, timer_windows[0], timer_windows[1], timer_windows[2]])
	
func _on_game_started() -> void:
	stream = beep

func _on_game_ended() -> void:
	stream = timer_end
	play()
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
var _subtimer_passed : float = 0
func _process(_delta: float) -> void:
	var _timer_time_passed : float = GameManager.TIMER_DURATION - GameManager.timer.time_left
	_subtimer_passed += _delta
	if GameManager.status == GameManager.GameStatus.RUNNING and !GameManager.timer.is_stopped():
		if _timer_time_passed > 0 and _timer_time_passed < timer_windows[0]:
			if _subtimer_passed > beep_distance_seconds[0]:
				play()
				_subtimer_passed = 0
		elif _timer_time_passed > timer_windows[0] and _timer_time_passed < timer_windows[1]:
			if _subtimer_passed > beep_distance_seconds[1]:
				play()
				_subtimer_passed = 0
		elif _timer_time_passed > timer_windows[1] and _timer_time_passed < timer_windows[2]:
			if _subtimer_passed > beep_distance_seconds[2]:
				play()
				_subtimer_passed = 0
		elif _timer_time_passed > timer_windows[2] and _timer_time_passed < GameManager.TIMER_DURATION:
			if _subtimer_passed > beep_distance_seconds[3]:
				play()
				_subtimer_passed = 0
			
