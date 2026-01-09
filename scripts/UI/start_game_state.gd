extends StateUI


class_name StartGameState


@export var player_list: HBoxContainer
@export var game_name: Label

const GAMES_DIR := "user://games"

@onready var player_ui_scene:PackedScene = load("res://scenes/player_ui.tscn")
@onready var next_scene:PackedScene = load("res://scenes/intro.tscn")


func enter_state():
	super.enter_state()
	game_name.text = GameManager.GAME_NAME

	for child in player_list.get_children():
		child.free()
	
	if player_ui_scene == null:
		push_error("Could not load player UI")
		return
	
	for i in range(len(GameManager.players)):

		var player_ui = player_ui_scene.instantiate() as PlayerUI
		
		player_ui.set_player(i)
		
		player_list.add_child(player_ui)

	

func _on_return_button_pressed():
	if (state_machine != null):
		state_machine.switch_state("game_select")
	else:
		push_error("No state_machine found")



func _on_start_game_pressed():
	leave_state()
	get_tree().change_scene_to_packed(next_scene)
