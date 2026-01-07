extends Control

class_name StateUI


"""
This is an abstract class for states in a UI
"""

@export var state:StateMachineUI.state

var state_machine:StateMachineUI 


func enter_state():
    self.visible = true

func leave_state():
    self.visible = false


func set_state_machine(state_m:StateMachineUI):
    state_machine = state_m
