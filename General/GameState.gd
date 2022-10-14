extends Node

var world : WorldController

var selectedShip : Ship setget set_selected_ship
signal ship_selection_Changed

func set_selected_ship(ship):
	selectedShip = ship
	emit_signal("ship_selection_Changed")

signal time_progressed(amount)

func progress_time(amount:int):
	emit_signal("time_progressed",amount)
