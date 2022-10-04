extends Panel

onready var inspectorContainer = $VBoxContainer

func set_Inspector(pannelArray):
	_clear_inspector()
	for pannel in pannelArray:
		inspectorContainer.add_child(pannel)
	
	
func _clear_inspector():
	for child in inspectorContainer.get_children():
		child.queue_free()
		inspectorContainer.remove_child(child)
