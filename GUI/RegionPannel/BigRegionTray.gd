extends Panel

func populate(region:Region):
	var compSegments = region.map_components(funcref(self,"get_region_comp_large_tray_segment"))
	for old_seg in $HBoxContainer.get_children():
		$HBoxContainer.remove_child(old_seg)
	for seg in compSegments:
		$HBoxContainer.add_child(seg)

	
func get_region_comp_large_tray_segment(comp):
	return comp.get_large_tray_slice()
