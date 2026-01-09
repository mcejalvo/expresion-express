extends Label

const ROTATION_CENTER : Vector2 = Vector2(-1000, 500)
const ROTATION_SPEED : float = 8 #8
const ROTATION_ANGLE : float = 5


func _ready() -> void:
	self.pivot_offset = ROTATION_CENTER
	#GameManager.game_ended.connect(_clear_label)
	GameManager.game_started.connect(_clear_label)
	#self.text = GameManager.pick_word()
func _clear_label() -> void:
	text = ""
	
func _input(event):
	if event.is_action_pressed("click"):
		print("Clicked to pass word.")
		var _rotation_duration = 1 / ROTATION_SPEED
		if GameManager.status == GameManager.GameStatus.RUNNING:
			var tween = create_tween()
			tween.tween_property(self, "rotation_degrees", -ROTATION_ANGLE, _rotation_duration)		
			tween.tween_callback(func():
				text = GameManager.pick_word()
			)
		else:
			print("\t Game is not running!")
