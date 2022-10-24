extends Control

export(NodePath) var _resourceSys

func _ready():
	var resourceSys = get_node(_resourceSys)
	for display in resourceSys.get_resource_displays():
		$HBoxContainer.add_child(display)
