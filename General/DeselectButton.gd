extends Button

func _ready():
	connect("button_down",self,"on_button_pressed")
	
func on_button_pressed():
	GameState.selection = null
