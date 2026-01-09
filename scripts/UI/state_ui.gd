extends Control

class_name StateUI


"""
This is an abstract class for states in a UI
"""

var state_machine:StateMachineUI 


func enter_state():
	self.visible = true

func leave_state():
	self.visible = false


func set_state_machine(state_m):
	state_machine = state_m


func get_state_machine():
	return state_machine

func handle_input(event:InputEvent):
	pass
	