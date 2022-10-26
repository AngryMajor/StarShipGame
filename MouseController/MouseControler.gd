extends Node2D

export(NodePath) var _highlightComp : NodePath
onready var highlightComp = get_node(_highlightComp)

var CurrMosueState setget _set_mouse_state

var coordUnderMouse
var timeOverCoord = 0
export(float) var timeTillTextbox = 1
var hoverBoxActive = false
export(PackedScene) var hoverBoxScene : PackedScene
var hoverBoxInst : Control

func _ready():
	self.CurrMosueState = get_child(0).name

func _process(delta):
		if timeOverCoord >= timeTillTextbox:
			create_hover_box(coordUnderMouse)
		else:
			timeOverCoord += delta
			
func create_hover_box(coord):
	if hoverBoxActive == true or coord == null:
		return
	hoverBoxActive = true
	if hoverBoxInst == null:
		hoverBoxInst = hoverBoxScene.instance()
		$"../GUILayer".add_child(hoverBoxInst)
	hoverBoxInst.visible = true
	hoverBoxInst.populate(coord)
	
func close_hover_box():
	if hoverBoxActive == false:
		return
	
	hoverBoxActive = false
	hoverBoxInst.visible = false

func _input(event):
	if event is InputEventMouseMotion:
		highlightComp.currser_highlight_coords = null

func _unhandled_input(event):
	var _map = GameState.world
	if event is InputEventMouseMotion:
		var coord = _map.convert_world_to_map_coors(get_global_mouse_position())
		highlightComp.currser_highlight_coords = coord
		if coord != coordUnderMouse:
			close_hover_box()
			timeOverCoord = 0
			coordUnderMouse = coord
		
	
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
