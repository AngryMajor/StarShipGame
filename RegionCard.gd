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

	self.connect("button_down",self,"_on_button_down")
	self.connect("mouse_entered",self,"_on_mouse_entered")
	self.connect("mouse_exited",self,"_on_mouse_exited")

func _on_button_down():
	if GameState.selection is Region:
		$Tray.visible = false

func _on_mouse_entered():
	if not GameState.selection is Region:
		$Tray.visible = true
	
func _on_mouse_exited():
	$Tray.visible = false
