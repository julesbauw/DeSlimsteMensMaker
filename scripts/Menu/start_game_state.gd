extends StateUI


class_name StartGameState


@export var player_list: HBoxContainer
@export var game_name: Label

const GAMES_DIR := "user://games"

func enter_state():
	super.enter_state()
	game_name.text = GameManager.GAME_NAME

	

func _on_return_button_pressed():
	if (state_machine != null):
		state_machine.switch_state(state_machine.state.SELECT_GAME)
	else:
		push_error("No state_machine found for state: " + str(state))

func _on_start_game_pressed():
	pass
