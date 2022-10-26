extends Mission

var _currState

func set_currState(value):
	_currState = value
func get_currState():
	if _currState == null:
		_currState = get_child(0)
	return _currState


func set_time_limit(amount):
	_currState.time_limit = amount
func get_time_limit():
	return _currState.time_limit

func set_hover_text(amount):
	_currState.hover_text = amount
func get_hover_text():
	return _currState.hover_text

func set_description(value):
	_currState.Description = value
func get_description():
	return _currState.Description
	
func set_icon_index(value):
	_currState.icon_index = value
func get_icon_index():
	return _currState.icon_index

func init(region):
	self.region = region
	_currState = get_child(0)
	for child in get_children():
		child.connect("RequestStateChange",self,"change_state")
		child.init(region)
	_currState._ongoing_start_effect()
	self.name = _currState.name

func on_time_progress(amount):
	_currState.on_time_progress(amount)
	
	if _completed == true:
		_remove_mission()

	if _currState.time_limit > -1:
		_currState.time_limit -= amount
		if _currState.time_limit <= 0:
			time_out()
		emit_signal("DataUpdated",self)

func time_out():
	_completed = true
	_currState._timeout_effect()
	_currState.icon_index = 4
	emit_signal("DataUpdated",self)

func execute(executor:MissionExecutor):
	if _currState._completed == true:
		return 
		
	_currState._complete_effect(executor)
	emit_signal("DataUpdated",self)

func change_state(target : Node):
	_currState._ongoing_end_effect()
	_currState = target
	self.name = _currState.name
	_currState._ongoing_start_effect()

func _remove_mission():
	_currState._ongoing_end_effect()
	$"../".remove_child(self)
	queue_free()
	emit_signal("DataUpdated",self)

