extends Node
class_name RegComp

export(PackedScene) var _smallTraySegment
onready var smallTraySegment = _smallTraySegment.instance()
export(PackedScene) var _largeTraySegment
onready var largeTraySegment = _largeTraySegment.instance()

func get_small_tray_slice():
	smallTraySegment.init(self)
	return smallTraySegment
	
func get_large_tray_slice():
	largeTraySegment.init(self)
	return largeTraySegment
