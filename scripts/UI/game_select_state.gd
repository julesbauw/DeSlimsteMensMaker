extends StateUI

class_name GameSelectState

@export var game_list: VBoxContainer
@export var name_input: LineEdit
@export var popup: AcceptDialog

const GAMES_DIR := "user://games"

func enter_state():
	super.enter_state()
	# load UI of existing games
	_load_games()
	GameManager.reset() #RESET GAMEMANAGER

func leave_state():
	super.leave_state()


func _ready():
	# check whether game directory exists, if not
	self.state = state_machine.state.SELECT_GAME
	_make_game_directory()

func _make_game_directory():
	if not DirAccess.dir_exists_absolute(GAMES_DIR):
		DirAccess.make_dir_absolute(GAMES_DIR)

func _load_games():
	# Oude knoppen verwijderen
	for child in game_list.get_children():
		child.queue_free()

	var dir := DirAccess.open(GAMES_DIR)
	if dir == null:
		return

	dir.list_dir_begin()
	var game_name := dir.get_next()
	while game_name != "":
		if dir.current_is_dir() and not game_name.begins_with("."):
			_add_game(game_name)
		game_name = dir.get_next()
	dir.list_dir_end()

func _add_game(game_name: String):
	var button := Button.new()
	button.text = game_name
	button.pressed.connect(func():
		_select_game(game_name)
	)
	game_list.add_child(button)

### SET IMPORTANT INFO TO THE GAME MANAGER!!
func _select_game(game_name: String):
	GameManager.GAME_NAME = game_name
	var player_dir_name = GAMES_DIR + "/" + GameManager.GAME_NAME + "/" + "players"
	
	if not DirAccess.dir_exists_absolute(player_dir_name):
		DirAccess.make_dir_absolute(player_dir_name)
		GameManager.players = []
	else:
		GameManager.players = FileParser.parse_players_from_directory(player_dir_name)

	print("Selected game:", GameManager.GAME_NAME)
	print("Player  amount: ", len(GameManager.players))
	state_machine.switch_state(state_machine.state.START_GAME)

func _on_create_game_pressed():
	name_input.text = ""
	popup.popup_centered()
	name_input.grab_focus()

func _on_create_game_popup_confirmed():
	var game_name := name_input.text.strip_edges()
	if game_name.is_empty():
		return

	var path := GAMES_DIR + "/" + game_name
	GameFileManager.create_game_directory(path)
	_load_games()
