extends Resource

class_name BaseEffect

static func trigger(mission):
	pass

static func start(mission):
	mission.region.get_component("Econemy").value -= 10
	
static func end(mission):
	mission.region.get_component("Econemy").value += 10

static func trigger_ongoing(mission):
	pass
