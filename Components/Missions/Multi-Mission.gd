extends Mission

var _currState

func set_time_limit(amount):
	_currState.time_limit = amount
func get_time_limit():
	return _currState.time_limit

func set_description(value):
	_currState.Description = value
func get_description():
	return _currState.Description
	
func set_icon_index(value):
	_currState.icon_index = value
func get_icon_index():
	return _currState.icon_index


func _ready():
	_currState = get_child(0)

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
			_currState.time_out()
		emit_signal("DataUpdated",self)

func time_out():
	_currState._timeout_effect()
	emit_signal("DataUpdated",self)

func complete():
	if _currState._completed == true:
		return 
		
	_currState._complete_effect()
	emit_signal("DataUpdated",self)

func change_state(target):
	_currState._ongoing_end_effect()
	_currState = target
	self.name = _currState.name
	_currState._ongoing_start_effect()

func _remove_mission():
	_currState._ongoing_end_effect()
	$"../".remove_child(self)
	queue_free()
	emit_signal("DataUpdated",self)

