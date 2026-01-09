extends Listener

class_name  PlayerUI

@export var name_label:Label

@export var score_label:RoundNumber

@export var texture: TextureRect


var timer_count = 1
var timer

var timer_on:bool = false

var player_model:Player


func _ready() -> void:
	timer = timer_count


func _process(delta: float) -> void:
	
	if player_model == null:
		return

	if not timer_on:
		return
	timer -= delta

	if timer < 0:
		player_model.score = player_model.score - 1
		timer = timer_count

	if player_model.score <= 0:
		print("dit?")
		timer_on = false

func set_player(i:int):
	player_model = GameManager.players[i]
	player_model.add_listener(self)

	name_label.text = player_model.player_name
	score_label.set_number_label(player_model.score)


	if player_model.image != null:
		texture.texture = player_model.image

func start_timer():
	if player_model.score > 0:
		timer_on = true

func select(timer:bool = true):

	score_label.toggle_on()
	if timer:
		start_timer()

func deselect():
	score_label.toggle_off()

	timer_on = false
	timer = timer_count

func update():
	name_label.text = player_model.player_name
	score_label.set_number_label(player_model.score)
	
func _exit_tree() -> void:
	if player_model != null:
		player_model.remove_listener(self)