extends Mission

var explorationComp

func init(region:Region):
	.init(region)

	self.name = "Anomaly " + String(rand_range(100,999) as int)
	explorationComp = region.get_component("Exploration")

func _complete_effect():
	explorationComp.percentComplete += 10
