extends Node


"""
This class manages the save files of the games
"""

const ROUNDS_DIR := "resources/rounds/" # path of default rounds resources, they are needed to have a example game



"""
In this fucntion we make the game directory
"""

func create_game_directory(path:String):

	if DirAccess.dir_exists_absolute(path):
		print("Game already exists")
		return

	DirAccess.make_dir_absolute(path)

	var dir = DirAccess.open(ROUNDS_DIR)

	if !(dir):
		return
	
	dir.list_dir_begin()
	var file_name := dir.get_next()

	## rounds

	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".tres"):
			print(file_name)
			var round_path := ROUNDS_DIR + file_name
			var resource:RoundDirectory = load(round_path) as RoundDirectory

			var round_directory := path + "/" + resource.name
			
			DirAccess.make_dir_absolute(round_directory)

			# help text

			var expl_file = FileAccess.open(round_directory + "/help.txt",FileAccess.WRITE)
			if expl_file == null:
				push_error("Could not open file: " + round_directory + "/help.txt")
			expl_file.store_string(resource.help_text)
			expl_file.close()
			
			for question_file in resource.init_files:
				var file_path = round_directory + "/" + question_file.name
				var file = FileAccess.open(file_path,FileAccess.WRITE)
				if file == null:
					push_error("Could not open file: " + file_path)
					continue
				file.store_string(question_file.questions)
				file.close()
			
			for question_dir_name in resource.init_dir:
				DirAccess.make_dir_absolute(round_directory + "/" + question_dir_name)

		file_name = dir.get_next()
	
	## players
	
	DirAccess.make_dir_absolute(path + "/players")
	for i in range(3):
		var file_path := path + "/players/player_example_" + str(i) + ".txt"
		var file := FileAccess.open(file_path, FileAccess.WRITE)

		if file == null:
			push_error("Could not open file: " + file_path)
			continue

		file.store_string(
			"player_name: Player" + str(i) + "\n" +
			"score: 60\n"
		)

		file.close()
