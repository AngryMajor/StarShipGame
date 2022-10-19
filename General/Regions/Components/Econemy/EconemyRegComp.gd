extends Node

signal ValueChanged

var value = 100 setget _set_value
export(PackedScene) var smallTraySegment

func _set_value(v):
	value = v
	emit_signal("ValueChanged")

func get_small_tray_slice():
	var seg = smallTraySegment.instance()
	seg.init(self)
	return seg
	
func get_large_tray_slice():
	var seg = smallTraySegment.instance()
	seg.init(self)
	return seg
