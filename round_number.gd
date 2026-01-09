extends Control

class_name RoundNumber
@export var number_label:Label


@export var label_settings_on:LabelSettings
@export var label_settings_off:LabelSettings



func set_number_label(value:int):

	if value < 0:
		number_label.text = "0"
	elif value > 999:
		number_label.text = "999"
	else:
		number_label.text = str(value)


func toggle_on():
	print(label_settings_on)
	number_label.label_settings = label_settings_on

func toggle_off():
	number_label.label_settings = label_settings_off