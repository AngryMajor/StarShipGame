extends RegComp

export(int) var peopleDev : int = 0
export(int) var progressDev : int = 0
export(int) var NatureDev : int = 0
var totalDevelopment setget ,_get_total_dev

func _get_total_dev():
	return peopleDev + progressDev + NatureDev
