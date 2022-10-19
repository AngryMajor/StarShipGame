extends Panel

func populate(region:Region):
	var compSegments = region.map_components(funcref(self,"get_region_comp_small_tray_segment"))
	for old_seg in $VBoxContainer.get_children():
		$VBoxContainer.remove_child(old_seg)
		old_seg.queue_free()
	for seg in compSegments:
		$VBoxContainer.add_child(seg)
	
func get_region_comp_small_tray_segment(comp):
	return comp.get_small_tray_slice()
