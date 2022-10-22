extends Control

func _ready():
	GameState.connect("selection_Changed",self,"_on_selection_changed")
	
func _on_selection_changed():
	if GameState.selection is Mission:
		self.populate(GameState.selection)
		self.margin_left = -self.rect_size.x-200
		self.margin_right = -200
	else:
		self.margin_left = 0

func populate(mission:Mission):
	$TextBlock.text = mission.Description
