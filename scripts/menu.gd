extends Node2D

class_name Menu

@export var start_game_ui:StartGameUI

@export var game_select_ui:GameSelectUI



func _ready() -> void:

    _to_game_select_menu()
    start_game_ui.menu = self
    game_select_ui.menu = self




func _to_start_game_menu():
    # resets everything
    start_game_ui.visible = true
    game_select_ui.visible = false
    start_game_ui.init_game()

func _to_game_select_menu():
    start_game_ui.visible = false
    game_select_ui.visible = true
    GameManager.reset()