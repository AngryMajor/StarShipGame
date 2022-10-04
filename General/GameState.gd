extends Node

var world : WorldController

signal time_progressed(amount)

func progress_time(amount:int):
	emit_signal("time_progressed",amount)
