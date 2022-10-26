extends Node
class_name Mission

var region : Region

signal DataUpdated()

export var time_limit = 3 setget set_time_limit,get_time_limit
export(String, MULTILINE) var Description = "" setget set_description,get_description
export(String, MULTILINE) var hover_text = "" setget set_hover_text,get_hover_text
export(int) var icon_index = 0 setget set_icon_index,get_icon_index

onready var region_id = get_parent().get_index()
var _completed = false setget set_completed, get_completed


func set_time_limit(amount):
	time_limit = amount
func get_time_limit():
	return time_limit
func set_description(value):
	Description = value
func get_description():
	return Description
func set_hover_text(amount):
	hover_text = amount
func get_hover_text():
	return hover_text
func set_icon_index(value):
	icon_index = value
func get_icon_index():
	return icon_index
func set_completed(value):
	_completed = value
func get_completed():
	return _completed
	
	
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

func _complete_effect(executor:MissionExecutor):
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
	icon_index = 4
	_timeout_effect()
	emit_signal("DataUpdated",self)


func execute(executor:MissionExecutor):
	if _completed == true:
		return 
		
	_completed = true
	icon_index = 3
	_complete_effect(executor)
	emit_signal("DataUpdated",self)


func _remove_mission():
	_ongoing_end_effect()
	$"../".remove_child(self)
	queue_free()
	emit_signal("DataUpdated",self)

