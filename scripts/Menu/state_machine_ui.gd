extends Control

class_name StateMachineUI

@export var initial_state:StateUI

enum state {
	SELECT_GAME,
	START_GAME,
	EDIT_GAME,
}

var states = {}

var current_state:StateUI

func _ready() -> void:
	
	for child in self.get_children():
		var child_state = child as StateUI
		if (!child_state):
			continue
		child_state.state_machine = self
		states[child_state.state] = child_state

	if initial_state:
		initial_state.enter_state()
		current_state = initial_state


func switch_state(new_state_enum:state):

	var new_state = states.get(new_state_enum)

	if (!new_state):
		return
	
	if current_state:
		current_state.leave_state()
		
	current_state = new_state
	new_state.enter_state()
