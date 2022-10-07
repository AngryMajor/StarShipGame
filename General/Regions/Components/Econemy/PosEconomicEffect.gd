extends Resource

class_name BaseEffect

func trigger(mission):
	pass

func start(mission):
	mission.region.get_component("Econemy").value -= 10
	
func end(mission):
	mission.region.get_component("Econemy").value += 10
