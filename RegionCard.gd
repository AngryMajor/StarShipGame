extends TextureButton

export(Texture) var baseTexture

func init(region:Region):
	$NameLabel.text = region.name
	var tex = AtlasTexture.new() as AtlasTexture
	tex.atlas = baseTexture
	tex.region.size = Vector2(64,64)
	tex.region.position.y = 128
	tex.region.position.x = 64 * region.id
	self.texture_normal = tex
