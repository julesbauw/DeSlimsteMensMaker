extends Model

class_name Player

@export var player_name: String:
	set(value):
		player_name = value
		_update_listeners()

@export var score: int:
	set(value):
		score = value
		_update_listeners()

@export var image_path: String:
	set(value):
		image_path = value
		_update_listeners()

@export var image: Texture2D:
	set(value):
		image = value
		_update_listeners()

