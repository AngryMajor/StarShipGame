extends Mission

var explorationComp

func init(region:Region):
	.init(region)
	self.name = "Explore " + String(region.name)
	explorationComp = region.get_component("Exploration")

func _complete_effect():
	explorationComp.percentComplete += 1
