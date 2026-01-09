extends Label

var base_font_size : int
var base_size : Vector2
var label : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.game_started.connect(_on_game_started)
	GameManager.game_ended.connect(_on_game_ended)
	label = self
	label.resized.connect(_set_text_size)
	base_size = label.size
	base_font_size = label.get_theme_font_size("font_size", label.get_class())

func _set_text_size() -> void:
	var new_size = label.size
	var scale = new_size.x / base_size.x
	var scaled_size : int = floor(base_font_size * scale)
	label.add_theme_font_size_override("font_scale", scaled_size)
	#print("Original Font Size: %d, New Font Size: %d" %[base_font_size, scaled_size])
	
	
	
	
func _on_game_started() -> void:
	text = "Parar"
	
func _on_game_ended() -> void:
	text = "Empezar"
