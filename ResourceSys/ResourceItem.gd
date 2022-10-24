extends Node

class_name ResourceItem

export(PackedScene) var resourceItemDisplay
export var _amount : int setget _change__amount
var _income : int setget _change_income

var _incomeModifiers = {}

var displayInst


func get_display_info() -> Node:
	if displayInst == null:
		displayInst = resourceItemDisplay.instance()
	displayInst.init(self)
	return displayInst

func _change__amount(new):
	_amount = new
	if displayInst != null:
		displayInst.init(self)
		
func _change_income(new):
	_income = new
	if displayInst != null:
		displayInst.init(self)

func add_income_modifier(name:String, _amount:int):
	if not name in _incomeModifiers:
		_incomeModifiers[name] = [_amount]
	else:
		_incomeModifiers[name].append(_amount)
	_recalculate_income()
		
func remove_income_modifier(name:String, _amount:int):
	if name in _incomeModifiers and _amount in _incomeModifiers[name]:
		_incomeModifiers[name].remove(_incomeModifiers[name].find(_amount))
		_recalculate_income()

func _recalculate_income():
	var prospectus_income = 0
	for name in _incomeModifiers.keys():
		for item in _incomeModifiers[name]:
			print(item)
			prospectus_income += item
	self._income = prospectus_income
	
func _ready():
	_recalculate_income()
	GameState.connect("time_progressed",self,"_gain_income")
	
func _gain_income(_amount):
	self._amount += self._income*_amount

func can_withdraw(amountRequested:int):
	return true
	
func withdraw(amountRequested:int) -> bool:
	if amountRequested <= 0 or can_withdraw(amountRequested) == false:
		return false
		
	self._amount -= amountRequested
	return true
	
func can_deposit(amountRequested:int):
	return true

func deposit(amountRequested:int) -> bool:
	if amountRequested <= 0 or can_deposit(amountRequested) == false:
		return false
		
	self._amount += amountRequested
	return true
