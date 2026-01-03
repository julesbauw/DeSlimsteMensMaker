extends Control

@export var game_list: VBoxContainer
@export var name_input: LineEdit
@export var popup: AcceptDialog

const GAMES_DIR := "user://games"

func _ready():
	# check whether game directory exists, if not
	_make_game_directory()
	# load UI of existing games
	_load_games()

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
	var name := dir.get_next()
	while name != "":
		print(name)
		if dir.current_is_dir() and not name.begins_with("."):
			_add_game(name)
		name = dir.get_next()
	dir.list_dir_end()

func _add_game(game_name: String):
	var button := Button.new()
	button.text = game_name
	button.pressed.connect(func():
		_select_game(game_name)
	)
	game_list.add_child(button)

func _select_game(game_name: String):
	print("Geselecteerde game:", game_name)

func _on_create_game_pressed():
	name_input.text = ""
	popup.popup_centered()
	name_input.grab_focus()

func _on_create_game_popup_confirmed():
	var game_name := name_input.text.strip_edges()
	if game_name.is_empty():
		return

	var path := GAMES_DIR + "/" + game_name
	if DirAccess.dir_exists_absolute(path):
		print("Game bestaat al")
		return

	DirAccess.make_dir_absolute(path)
	_load_games()
