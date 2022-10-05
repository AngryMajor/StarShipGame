extends Node


onready var id = get_position_in_parent()

export(int) var artificial_number

var visualSlots = []

func get_data():
	var return_dict = {"art_num":artificial_number}
	return return_dict

func asign_slot(slot:RegionVisualSlot):
	visualSlots.append(slot)

func request_visual_slot(target : Node):
	var i = 0
	var target_slot = visualSlots[i]
	while i < visualSlots.size() and target_slot.target != null:
		target_slot = visualSlots[++i]
	
	if i >= visualSlots.size(): 
		return null
	else:
		target_slot.target = target
		return target_slot
