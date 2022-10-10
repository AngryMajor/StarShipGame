extends Button

func _ready():
	self.connect("button_up",self,"on_button_pressed")
	
func on_button_pressed():
	GameState.progress_time(1)
