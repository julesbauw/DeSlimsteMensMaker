extends Control

class_name StartGameUI


@export var player_list: HBoxContainer
@export var game_name: Label

var menu:Menu



func init_game():
	game_name.text = GameManager.GAME_NAME

func _on_return_button_pressed():
	menu._to_game_select_menu()


func _on_start_game_pressed():
	pass
