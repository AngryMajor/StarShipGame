extends Object
class_name RegionVisualSlot

signal target_updated

var region : int
var target : Node setget set_target

func set_target(t):
	target = t
	emit_signal("target_updated")
