extends Node
class_name MissionExecutor

export(int) var maxPower :int = 11
var currPower :int = 3 setget _set_curr_power

func _set_curr_power(value):
	currPower = value
	emit_signal("DataUpdated")
	
