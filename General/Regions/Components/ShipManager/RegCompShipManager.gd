extends RegComp

export(bool) var refulingStationActive = false

signal Region_empty

var shipsInRegion = []

func _enter_tree():
	GameState.connect("post_time_progressed",self,"_on_post_time_progressed")
func _exit_tree():
	GameState.disconnect("post_time_progressed",self,"_on_post_time_progressed")
	
func _on_post_time_progressed():
	if refulingStationActive:
		for s in shipsInRegion:
			var ship = s as Ship
			ship.repower()
	
func ship_enter(ship:Ship):
	shipsInRegion.append(ship)

func ship_leave(ship:Ship):
	var ship_index = shipsInRegion.find(ship)
	if ship_index != -1:
		shipsInRegion.remove(ship_index)
	if shipsInRegion.size() < 1:
		emit_signal("Region_empty")

