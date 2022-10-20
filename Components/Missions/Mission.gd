extends Node
class_name Mission

var region

signal MissionComplete()
signal MissionTimedOut()

export var time_limit = 3

export(String, MULTILINE) var Description = ""

export(int) var icon_index = 0

onready var region_id = get_parent().get_index()
var _completed = false

func _enter_tree():
	GameState.connect("time_progressed",self,"on_time_progress")

func _exit_tree():
	GameState.disconnect("time_progressed",self,"on_time_progress")

func _ongoing_start_effect():
	pass

func _ongoing_effect(amount):
	pass
	
func _ongoing_end_effect():
	pass

func _complete_effect():
	pass
	
func _timeout_effect():
	pass

func init(region):
	self.region = region
	_ongoing_start_effect()

func on_time_progress(amount):
	_ongoing_effect(amount)
	if _completed == true:
		return
	
	if time_limit > -1:
		time_limit -= amount
		if time_limit <= 0:
			time_out()

func time_out():
	_timeout_effect()
	_remove_mission()
	emit_signal("MissionTimedOut",self)


func complete():
	_completed = true
	_complete_effect()
	_remove_mission()
	emit_signal("MissionComplete",self)


func _remove_mission():
	_ongoing_end_effect()
	$"../".remove_child(self)
	queue_free()

