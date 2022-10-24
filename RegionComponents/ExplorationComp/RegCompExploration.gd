extends RegComp

var percentComplete = 0

func check_for_anomaly():
	if rand_range(0,100) < 30:
		$MissionGenerator.generate_anomaly()
