extends Control

class_name RoundNumber
@export var number_label:Label



func set_number_label(value:int):

	if value < 0:
		number_label.text = "0"
	elif value > 999:
		number_label.text = "999"
	else:
		number_label.text = str(value)
		
