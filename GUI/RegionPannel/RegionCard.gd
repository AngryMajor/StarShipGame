extends TextureButton

export(Texture) var baseTexture

var my_region

func _enter_tree():
	GameState.connect("selection_Changed",self,"_on_selection_changed")
	
func _exit_tree():
	GameState.disconnect("selection_Changed",self,"_on_selection_changed")

func init(region:Region):
	my_region = region
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
		$Tray.populate(my_region)
		$Tray.visible = true
	
func _on_mouse_exited():
	$Tray.visible = false
	
func _on_selection_changed():
	if GameState.selection == my_region:
		$HightlightTexture.visible = true
	else:
		$HightlightTexture.visible = false
