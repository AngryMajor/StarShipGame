extends RegComp

var percentComplete = 0

func check_for_discovery():
	if rand_range(0,100) < 30:
		$MissionGenerator.generate_discovery()

func crease_more_exploration_missions(amount:int=1):
	if amount <= 0:
		return
	for i in range(0,amount):
		$MissionGenerator.create_new_exploration_mission()
	
