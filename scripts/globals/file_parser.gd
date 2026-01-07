extends Node


"""
This class reads files and parses them
"""

const FILE_DILIMITER = ":"

func parse_players_from_directory(player_dir_name) -> Array[Player]:

	var player_dir = DirAccess.open(player_dir_name)

	player_dir.list_dir_begin()
	var player_file_name = player_dir.get_next()

	var players:Array[Player] = []

	while player_file_name != "":
		if not player_dir.current_is_dir() and player_file_name.ends_with(".txt"):
			var player_file_path = player_dir_name + "/" + player_file_name
			var player = FileParser.parse_player_file(player_file_path)
			if (player != null):
				players.append(player)
		player_file_name = player_dir.get_next()
	
	for player in players:
		var full_image_path = player_dir_name + "/" + player.image_path
		if player.image_path != "" and FileAccess.file_exists(full_image_path):
			print("image_found")
			player.image = load(full_image_path)
		
	return players

func parse_player_file(file_path:String) -> Player:
	

	var player_dict = parse_file_to_dict(file_path)

	var player:Player = Player.new()

	resource_fill_fields(player,player_dict)

	return player


func parse_file_to_dict(file_path:String) -> Dictionary:

	var file = FileAccess.open(file_path,FileAccess.READ)

	if not file:
		return {}
	
	var result = {}
	
	var line  = file.get_line()

	while not file.eof_reached():
		var split_line = line.split(FILE_DILIMITER,true,1)

		if len(split_line) < 2:
			line = file.get_line()
			continue

		var field = split_line[0].strip_edges()
		var value = split_line[1].strip_edges()
		
		result[field] = value
		line = file.get_line()
	
	return result


func resource_fill_fields(res: Resource, data: Dictionary):
	var properties = {}
	for prop_dict in res.get_property_list():
		properties[prop_dict["name"]] = null

	for key in data.keys():
		if key in properties:
			
			var value = data[key]

			var prop_type = typeof(res.get(key))

			match prop_type:
				TYPE_INT:
					res.set(key,int(value))
				TYPE_FLOAT:
					res.set(key,float(value))
				TYPE_STRING:
					res.set(key,str(value))
				_:
					res.set(key,value)
				

	