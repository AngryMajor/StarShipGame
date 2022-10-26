extends Control

var my_ship : Ship
export(Texture) var baseTexture : Texture
signal ship_selection_request(ship)

func init(ship:Ship):
	var button = $ShipButton as TextureButton
	var atlasTexture = AtlasTexture.new()
	atlasTexture.atlas = baseTexture
	atlasTexture.region.size = Vector2(64,64)
	atlasTexture.region.position = Vector2(0,128)
	button.texture_normal = atlasTexture
	
	my_ship = ship
	my_ship.connect("DataUpdated",self,"_on_ship_updated")
	$ShipLabel.text = my_ship.name
	_on_ship_updated()
	display_ship_Region()
	check_ship_available()
	$ShipButton.connect("button_down",self,"on_button_down")
	
	GameState.connect("selection_Changed",self,"on_selection_changed")
	on_selection_changed()

func on_selection_changed():
	if my_ship == GameState.selection:
		$ShipButton/HighlightTexture.visible = true
	else:
		$ShipButton/HighlightTexture.visible = false

func _on_ship_updated():
	$APLable.text = String(my_ship.currAP)
	$FuleLable.text = String(my_ship.currFule)
	check_ship_available()
	display_ship_Region()

func on_button_down():
	emit_signal("ship_selection_request",my_ship)
	
func display_ship_Region():
	$LocationLable.text = my_ship.region.name
	set_button_color()
	
func check_ship_available():
	if my_ship.currAP > 0:
		$ShipButton.is_ship_available = true
	else:
		$ShipButton.is_ship_available = false
	
func set_button_color():
	$ShipButton.set_region_color(my_ship.region.id)

