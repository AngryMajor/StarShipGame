extends Control

export(NodePath) var RegionList
onready var _region_list = get_node(RegionList)

export(PackedScene) var RegionDispaly

func _ready():
	for region_data in _region_list.get_children():
		var region_pannel = RegionDispaly.instance()
		region_pannel.init(region_data)
		$VBoxContainer.add_child(region_pannel)
	pass
