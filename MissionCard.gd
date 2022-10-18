extends Control

export(Texture) var baseTexture : Texture

func set_dim(value:bool):
	if value:
		self.modulate = Color(0.5,0.5,0.5,0.8)
	else:
		self.modulate = Color(1,1,1,1)

func init(mission):
	$MissionCard/NameLabel.text = String(mission.name)
	
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
	$MissionCard/TextureRect.texture = Icon_atlasTexture
	

func rerender():
	self.visible = false
	self.visible = true

func set_region_color(reginoid):
	$RegionTexture.texture.region.position.x = reginoid * 64
	rerender()
