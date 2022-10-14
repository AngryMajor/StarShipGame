extends Panel

export(PackedScene) var shipGUICard
export (NodePath) var ship_List
onready var shipList = get_node(ship_List)

export (NodePath) var _shipComp
onready var shipComp = get_node(_shipComp)

func _ready():
	for ship in shipList.get_children():
		var card = shipGUICard.instance() 
		card.init(ship)
		$HBoxContainer.add_child(card)
		card.connect("ship_selection_request",self,"on_ship_selection_request")
		
func on_ship_selection_request(ship:Ship):
	GameState.selectedShip = ship
