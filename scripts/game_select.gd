extends Control

class_name GameSelectUI

@export var game_list: VBoxContainer
@export var name_input: LineEdit
@export var popup: AcceptDialog

const GAMES_DIR := "user://games"

const ROUNDS_DIR := "resources/rounds/"

var menu:Menu


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
	GameManager.GAME_NAME = game_name
	print("Selected game:", GameManager.GAME_NAME)
	menu._to_start_game_menu()

func _on_create_game_pressed():
	name_input.text = ""
	popup.popup_centered()
	name_input.grab_focus()


"""
In this section we make the file directory, TODO -> to other script
"""

func _on_create_game_popup_confirmed():
	var game_name := name_input.text.strip_edges()
	if game_name.is_empty():
		return

	var path := GAMES_DIR + "/" + game_name
	if DirAccess.dir_exists_absolute(path):
		print("Game already exists")
		return

	DirAccess.make_dir_absolute(path)

	var dir = DirAccess.open(ROUNDS_DIR)

	if !(dir):
		return
	
	dir.list_dir_begin()
	var file_name := dir.get_next()

	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".tres"):
			print(file_name)
			var round_path := ROUNDS_DIR + file_name
			var resource:RoundDirectory = load(round_path) as RoundDirectory

			var round_directory := path + "/" + resource.name
			
			DirAccess.make_dir_absolute(round_directory)

			var expl_file = FileAccess.open(round_directory + "/help.txt",FileAccess.WRITE)
			expl_file.store_string(resource.help_text)

			for question_file in resource.init_files:
				print(question_file.name)
				var file = FileAccess.open(round_directory + "/" + question_file.name,FileAccess.WRITE)
				file.store_string(question_file.questions)
			
			for question_dir_name in resource.init_dir:
				DirAccess.make_dir_absolute(round_directory + "/" + question_dir_name)

		file_name = dir.get_next()
	_load_games()
