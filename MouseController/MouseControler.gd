extends Node2D

export(NodePath) var _highlightComp : NodePath
onready var highlightComp = get_node(_highlightComp)

var CurrMosueState setget _set_mouse_state

func _ready():
	self.CurrMosueState = get_child(0).name

func _input(event):
	if event is InputEventMouseMotion:
		highlightComp.currser_highlight_coords = null

func _unhandled_input(event):
	var _map = GameState.world
	if event is InputEventMouseMotion:
		var coord = _map.convert_world_to_map_coors(get_global_mouse_position())
		highlightComp.currser_highlight_coords = coord
	
	if event is InputEventMouseButton and event.is_pressed():
		var event_dict = {}
		
		event_dict["tileCoords"] = _map.convert_world_to_map_coors(get_global_mouse_position())
		event_dict["button"] = event.button_index
		
		CurrMosueState.handel_input(event_dict)
		
	if event is InputEventKey and event.is_pressed() and event.scancode == KEY_ESCAPE:
		GameState.selection = null
		
func _set_mouse_state(stateName:String):
	if stateName == null:
		return
		
	var stateNode = get_node(stateName)
	if stateNode != null:
		CurrMosueState = stateNode


func _on_Button_NewCommandSet(stateName):
	_set_mouse_state(stateName)
