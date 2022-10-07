extends Resource

static func trigger(mission):
	mission.region.get_component("Econemy").value += 10

static func start(mission):
	pass
	
static func end(mission):
	pass

static func trigger_ongoing(mission,amount):
	pass
