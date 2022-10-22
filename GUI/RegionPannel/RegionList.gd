extends Panel

export(NodePath) var _regionList
export(PackedScene) var _regionCard

func _ready():
	GameState.connect("selection_Changed",self,"_on_selection_changed")
	for region in get_node(_regionList).get_children():
		var regionCard = _regionCard.instance()
		regionCard.init(region)
		$HBoxContainer.add_child(regionCard)
		regionCard.connect("button_down",self,"_region_button_pressed",[region])

func _region_button_pressed(region:Region):
	GameState.selection = region
	
func _on_selection_changed():
	if GameState.selection is Region:
		$BigRegionTray.visible = true
		$BigRegionTray.populate(GameState.selection)
	else:
		$BigRegionTray.visible = false
