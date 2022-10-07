extends Node

signal ValueChanged

var value = 100 setget _set_value

func _set_value(v):
	value = v
	emit_signal("ValueChanged")
