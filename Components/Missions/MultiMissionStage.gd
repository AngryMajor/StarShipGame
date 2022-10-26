extends Node
class_name MutiMissionStage

export var time_limit = 3 
export(String, MULTILINE) var Description = "" 
export(int) var icon_index = 0 

onready var region_id = get_parent().get_index()
var _completed = false

signal RequestStateChange(target)

func _ongoing_start_effect():
	pass

func _ongoing_effect(amount):
	pass
	
func _ongoing_end_effect():
	pass

func _complete_effect(executor:MissionExecutor):
	pass
	
func _timeout_effect():
	pass

func init(region:Region):
	pass

func on_time_progress(amount):
	pass
