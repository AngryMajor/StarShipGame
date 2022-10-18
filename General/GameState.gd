extends Node

var world : WorldController

var selection setget set_selected
signal selection_Changed

func set_selected(target):
	selection = target
	emit_signal("selection_Changed")

signal time_progressed(amount)

func progress_time(amount:int):
	emit_signal("time_progressed",amount)
