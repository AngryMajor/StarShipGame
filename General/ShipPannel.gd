extends Panel

export(PackedScene) var shipGUICard
export (NodePath) var ship_List

onready var shipList = get_node(ship_List)

func _ready():
	for ship in shipList.get_children():
		var card = shipGUICard.instance() 
		card.init(ship)
		$HBoxContainer.add_child(card)
