extends VBoxContainer

class_name  PlayerUI

@export var name_label:Label

@export var score_label:Label

@export var texture: TextureRect




func set_player(player:Player):
	name_label.text = player.player_name
	score_label.text = str(player.score)
	
	if player.image != null:
		print("gebeut dit?")
		texture.texture = player.image
