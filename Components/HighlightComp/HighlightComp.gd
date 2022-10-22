extends Node

signal data_updated

var selectionMap = {}
export var highlight_selected = true setget set_highlight_selected
export var highlight_currser = true

export(NodePath) var _shipComp
onready var shipComp = get_node(_shipComp)
onready var missionComp = GameState.world.get_componnet("MissionComp")

var selected_coords
var currser_highlight_coords setget set_curser_highlight


func _ready():
	if GameState.selection is Ship:
		selected_coords = shipComp.get_ship_coord(GameState.selection)
	GameState.connect("selection_Changed",self,"on_selection_changed")
	shipComp.connect("data_updated",self,"on_ship_moved")

func set_curser_highlight(coord):
	var old_coord = currser_highlight_coords
	currser_highlight_coords = coord
	if old_coord != null:
		emit_signal("data_updated",old_coord)
	if currser_highlight_coords != null:
		emit_signal("data_updated",currser_highlight_coords)

func set_highlight_selected(value):
	highlight_selected = value
	emit_signal("data_updated",selected_coords)

func get_data(coord):
	var returnDict = {}
	if highlight_selected and coord == selected_coords:
		returnDict["Selected"] = GameState.selection
	elif highlight_currser and coord == currser_highlight_coords:
		returnDict["Selected"] = 1
	elif coord in selectionMap:
		returnDict["Selected"] = selectionMap[coord]
	return returnDict

func on_ship_moved(coord):
	on_selection_changed()

func on_selection_changed():		
	if GameState.selection is Ship and shipComp.get_ship_coord(GameState.selection) != null:
		var old_selection_coords = selected_coords
		selected_coords = shipComp.get_ship_coord(GameState.selection)
		if old_selection_coords != null:
			emit_signal("data_updated",old_selection_coords)
		emit_signal("data_updated",selected_coords)
	elif GameState.selection is Mission and missionComp.get_mission_coord(GameState.selection) != null:
		var old_selection_coords = selected_coords
		selected_coords = missionComp.get_mission_coord(GameState.selection)
		if old_selection_coords != null:
			emit_signal("data_updated",old_selection_coords)
		emit_signal("data_updated",selected_coords)
	else:
		var old_selection_coords = selected_coords
		selected_coords = null
		if old_selection_coords != null:
			emit_signal("data_updated",old_selection_coords)
		
	
func set_selected(coord):
	var toBeClearedCoords = selectionMap.keys()
	selectionMap.clear()
	for clearedCoor in toBeClearedCoords:
		emit_signal("data_updated",clearedCoor)
	selectionMap[coord] = 22

	emit_signal("data_updated",coord)
