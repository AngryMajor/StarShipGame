extends Node
class_name RegComp

export(PackedScene) var smallTraySegment

func get_small_tray_slice():
	var seg = smallTraySegment.instance()
	seg.init(self)
	return seg
	
func get_large_tray_slice():
	var seg = smallTraySegment.instance()
	seg.init(self)
	return seg
