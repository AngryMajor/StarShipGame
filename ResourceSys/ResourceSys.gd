extends Node

func get_resource_displays():
	var returnArray = []
	
	for comp in self.get_children():
		returnArray.append(comp.get_display_info())

	return returnArray

func get_resourceItem(name:String):
	var target = null
	for child in get_children():
		if child.name == name:
			target = child
	return target

func request_resource(name:String, amountRequested:int) -> bool:
	if amountRequested <=0:
		return false
		
	var target = null
	for child in get_children():
		if child.name == name:
			target = child
	
	if target != null and target.can_withdraw(amountRequested):
		target.withdraw(amountRequested)
		return true	
		
	return false
