extends Node
class_name Mission

var region

signal MissionComplete()
signal MissionTimedOut()

export var time_limit = 3

export(Resource) var effect_completed = null
export(Resource) var effect_failed = null
export(Resource) var effect_ongoing = null
export(String, MULTILINE) var Description = ""

export(int) var icon_index = 0

onready var region_id = get_parent().get_index()
var _completed = false

func _enter_tree():
	GameState.connect("time_progressed",self,"on_time_progress")

func _exit_tree():
	GameState.disconnect("time_progressed",self,"on_time_progress")

func init(region):
	self.region = region
	if effect_ongoing != null:
		effect_ongoing.start(self)

func on_time_progress(amount):
	if effect_ongoing != null:
		effect_ongoing.trigger_ongoing(self,amount)
	if _completed == true:
		return
	
	if time_limit > -1:
		time_limit -= amount
		if time_limit <= 0:
			time_out()

func time_out():
	if effect_failed != null:
		effect_failed.trigger(self)
	_remove_mission()
	emit_signal("MissionTimedOut",self)


func complete():
	_completed = true
	if effect_completed != null:
		effect_completed.trigger(self)
	_remove_mission()
	emit_signal("MissionComplete",self)


func _remove_mission():
	if effect_ongoing != null:
		effect_ongoing.end(self)
	$"../".remove_child(self)
	queue_free()

