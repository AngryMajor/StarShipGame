extends Node

var world : WorldController
signal time_progressed(amount)
signal post_time_progressed()

var selection setget set_selected
signal selection_Changed


func set_selected(target):
	selection = target
	emit_signal("selection_Changed")



func progress_time(amount:int):
	emit_signal("time_progressed",amount)
	emit_signal("post_time_progressed")
