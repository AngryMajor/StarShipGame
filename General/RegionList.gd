extends Panel

export(NodePath) var _regionList
export(PackedScene) var _regionCard

func _ready():
	for region in get_node(_regionList).get_children():
		var regionCard = _regionCard.instance()
		regionCard.init(region)
		$HBoxContainer.add_child(regionCard)
