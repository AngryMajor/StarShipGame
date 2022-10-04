extends Button

signal NewCommandSet(stateName)

func _pressed():
	emit_signal("NewCommandSet",self.text)
