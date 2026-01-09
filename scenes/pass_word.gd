extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.passed_word.connect(_on_clicked_word)
	
func _on_clicked_word() -> void:
	play()
