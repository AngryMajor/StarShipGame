extends Panel

func populate(region:Region):
	var compSegments = region.map_components(funcref(self,"get_region_comp_large_tray_segment"))
	for old_seg in self.get_children():
		self.remove_child(old_seg)
		old_seg.queue_free()
	for seg in compSegments:
		self.add_child(seg)

	
func get_region_comp_large_tray_segment(comp):
	return comp.get_large_tray_slice()
