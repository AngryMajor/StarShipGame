extends TileMap

var selected_tiles:Array

const highlight_tile_index = 22

func set_highlighted_tiles(tiles:Array):
	_reset_highlighted()
	add_highlighted_tiles(tiles)
	
func add_highlighted_tiles(tiles:Array):
	for tile in tiles:
		selected_tiles.append(tile)
		self.set_cellv(tile,highlight_tile_index)
	
func remove_highlighted_tiles(tiles:Array):
	for tile in tiles:
		selected_tiles.remove(selected_tiles.find(tile))
		self.set_cellv(tile,-1)

func _reset_highlighted():
	remove_highlighted_tiles(selected_tiles)
	selected_tiles.clear()
