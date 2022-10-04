extends Node2D

var CurrMosueState setget _set_mouse_state

func _ready():
	self.CurrMosueState = get_child(0).name

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var event_dict = {}
		
		var _map = GameState.world

		event_dict["tileCoords"] = _map.convert_world_to_map_coors(get_global_mouse_position())

		CurrMosueState.handel_input(event_dict)

func _set_mouse_state(stateName:String):
	if stateName == null:
		return
		
	var stateNode = get_node(stateName)
	if stateNode != null:
		CurrMosueState = stateNode


func _on_Button_NewCommandSet(stateName):
	_set_mouse_state(stateName)
