extends TileMap

func get_data_coord_map() -> Dictionary:
	var return_dict = {}
	
	var bounding = get_used_rect()
	for x in range(bounding.position.x,bounding.end.x):
		for y in range(bounding.position.y,bounding.end.y):
			var vec = Vector2(x,y)
			var data = get_data_for(vec)
			
			if data != -1:
				return_dict[vec] = data
			
	
	return return_dict

func get_data_for(coords):
	if get_cellv(coords) == -1:
		return -1
	else:
		return self.get_cellv(coords)-16
		

func _ready():
	queue_free()
	

