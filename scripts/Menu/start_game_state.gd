extends StateUI
class_name StartGameState


@export var player_list: HBoxContainer
@export var game_name: Label

func enter_state():
	super.enter_state()
	game_name.text = GameManager.GAME_NAME

func _on_return_button_pressed():
	state_machine.switch_state(state_machine.state.SELECT_GAME)

func _on_start_game_pressed():
	pass
