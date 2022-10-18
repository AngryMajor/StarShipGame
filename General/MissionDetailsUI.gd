extends Control

func _ready():
	GameState.connect("selection_Changed",self,"_on_selection_changed")
	
func _on_selection_changed():
	if GameState.selection is Mission:
		self.margin_left = -self.rect_size.x
	else:
		self.margin_left = 0
