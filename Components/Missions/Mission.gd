extends Node
class_name Mission

var region : Region

signal MissionComplete()
signal MissionTimedOut()
signal MissionToRemove()
signal DataUpdated()

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
		_remove_mission()

	if time_limit > -1:
		time_limit -= amount
		if time_limit <= 0:
			time_out()
		emit_signal("DataUpdated",self)

func time_out():
	_completed = true
	_timeout_effect()
	icon_index = 4
	emit_signal("DataUpdated",self)


func complete():
	if _completed == true:
		return 
		
	_completed = true
	_complete_effect()
	icon_index = 3
	emit_signal("DataUpdated",self)


func _remove_mission():
	_ongoing_end_effect()
	$"../".remove_child(self)
	queue_free()
	emit_signal("DataUpdated",self)

