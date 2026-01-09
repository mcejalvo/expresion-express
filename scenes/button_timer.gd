extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _pressed() -> void:
	print("Timer pressed!")
	GameManager.toggle_status()
