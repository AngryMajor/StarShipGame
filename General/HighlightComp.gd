extends Node

signal data_updated

var selectionMap = {}
export var highlight_selected_ship = true setget set_highlight_selected_ship
export var highlight_currser = true

export(NodePath) var _shipComp
onready var shipComp = get_node(_shipComp)

var selected_ship_coords
var currser_highlight_coords setget set_curser_highlight

func set_curser_highlight(coord):
	var old_coord = currser_highlight_coords
	currser_highlight_coords = coord
	if old_coord != null:
		emit_signal("data_updated",old_coord)
	emit_signal("data_updated",currser_highlight_coords)

func set_highlight_selected_ship(value):
	highlight_selected_ship = value
	emit_signal("data_updated",selected_ship_coords)

func get_data(coord):
	var returnDict = {}
	if highlight_selected_ship and coord == selected_ship_coords:
		returnDict["Selected"] = GameState.selectedShip
	elif highlight_currser and coord == currser_highlight_coords:
		returnDict["Selected"] = 1
	elif coord in selectionMap:
		returnDict["Selected"] = selectionMap[coord]
	return returnDict

func _ready():
	selected_ship_coords = shipComp.get_ship_coord(GameState.selectedShip)
	GameState.connect("ship_selection_Changed",self,"on_ship_selection_changed")
	shipComp.connect("data_updated",self,"on_ship_moved")

	
func on_ship_moved(coord):
	on_ship_selection_changed()

func on_ship_selection_changed():		
	if shipComp.get_ship_coord(GameState.selectedShip) != null:
		var old_selection_coords = selected_ship_coords
		selected_ship_coords = shipComp.get_ship_coord(GameState.selectedShip)
		emit_signal("data_updated",old_selection_coords)
		emit_signal("data_updated",selected_ship_coords)
	
func set_selected(coord):
	var toBeClearedCoords = selectionMap.keys()
	selectionMap.clear()
	for clearedCoor in toBeClearedCoords:
		emit_signal("data_updated",clearedCoor)
	selectionMap[coord] = 22

	emit_signal("data_updated",coord)
