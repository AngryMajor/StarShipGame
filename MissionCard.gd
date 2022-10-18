extends Control

export(Texture) var baseTexture : Texture
var myMission

func set_dim(value:bool):
	if value:
		self.modulate = Color(0.5,0.5,0.5,0.8)
	else:
		self.modulate = Color(1,1,1,1)

func init(mission):
	myMission = mission
	GameState.connect("selection_Changed",self,"_on_selection_changed")
	$Button.connect("button_down",self,"_on_button_pressed")
	
	$Button.text = String(mission.name)
	
	var background_atlasTexture = AtlasTexture.new()
	background_atlasTexture.atlas = baseTexture
	background_atlasTexture.region.size = Vector2(64,64)
	background_atlasTexture.region.position = Vector2(0,128)
	$RegionTexture.texture = background_atlasTexture
	set_region_color(mission.region.id)
	
	var Icon_atlasTexture = AtlasTexture.new()
	Icon_atlasTexture.atlas = baseTexture
	Icon_atlasTexture.region.size = Vector2(64,64)
	Icon_atlasTexture.region.position = Vector2(0,64)
	Icon_atlasTexture.region.position.x = mission.icon_index * 64 + 128
	$Button.icon = Icon_atlasTexture
	
func _on_button_pressed():
	GameState.selection = myMission

func _on_selection_changed():
	pass

func rerender():
	self.visible = false
	self.visible = true

func set_region_color(reginoid):
	$RegionTexture.texture.region.position.x = reginoid * 64
	rerender()
