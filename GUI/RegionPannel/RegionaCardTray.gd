extends Panel

func populate(region:Region):
	var compSegments = region.map_components(funcref(self,"get_region_comp_small_tray_segment"))
	for old_seg in $VBoxContainer.get_children():
		$VBoxContainer.remove_child(old_seg)
	for seg in compSegments:
		$VBoxContainer.add_child(seg)
	set_tray_size()	
	
func get_region_comp_small_tray_segment(comp):
	return comp.get_small_tray_slice()

func set_tray_size():
	if self.get_child_count() > 0:
		self.rect_size.y = $VBoxContainer.get_child(0).rect_size.y * $VBoxContainer.get_child_count()
		self.margin_bottom = $VBoxContainer.get_child(0).rect_size.y * $VBoxContainer.get_child_count() + ($VBoxContainer.get_child(0).rect_size.y)/2
	else:
		self.rect_size.y = 0
		self.margin_bottom = 0
