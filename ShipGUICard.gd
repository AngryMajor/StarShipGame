extends Control

var my_ship : Ship

func init(ship:Ship):
	my_ship = ship
	my_ship.connect("DataUpdated",self,"_on_ship_updated")
	$ShipLabel.text = my_ship.name
	$APLable.text = String(my_ship.currAP)
	set_button_color()
	check_ship_available()

func _on_ship_updated():
	$APLable.text = String(my_ship.currAP)
	check_ship_available()
	
	set_button_color()
	
func check_ship_available():
	if my_ship.currAP > 0:
		$ShipButton.is_ship_available = true
	else:
		$ShipButton.is_ship_available = false
	
func set_button_color():
	$ShipButton.set_region_color(my_ship.region.id)

