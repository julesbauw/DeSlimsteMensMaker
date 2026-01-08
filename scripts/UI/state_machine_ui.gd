extends Control

class_name StateMachineUI

@export var initial_state:StateUI


var states:Dictionary = {}

var current_state:StateUI

func _ready() -> void:
	
	for child in self.get_children():
		var child_state := child as StateUI
		if child_state == null:
			continue
		child_state.set_state_machine(self)
		states[child_state.name.to_lower()] = child_state

	if initial_state:
		initial_state.enter_state()
		current_state = initial_state


func switch_state(new_state_name:String):

	var new_state = states.get(new_state_name)

	if (new_state == null):
		return
	
	if current_state:
		current_state.leave_state()
		
	current_state = new_state
	new_state.enter_state()
	for s in states:
		print(states[s].state_machine)
