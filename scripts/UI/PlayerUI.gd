extends VBoxContainer

class_name  PlayerUI

@export var name_label:Label

@export var score_label:RoundNumber

@export var texture: TextureRect


var index:int

var timer_count = 1
var timer

var timer_on:bool


func _ready() -> void:
	timer = timer_count
	timer_on = false


func _process(delta: float) -> void:
	
	if not timer_on:
		return
	
	if len(GameManager.players) <= index:
		return
	timer -= delta

	if timer < 0:
		GameManager.players[index].score -= 1
		score_label.set_number_label(GameManager.players[index].score)
		timer = timer_count

	if GameManager.players[index].score <= 0:
		timer_on = false

func set_player(i:int):
	index = i
	var player = GameManager.players[i]
	name_label.text = player.player_name

	score_label.set_number_label(player.score)


	if player.image != null:
		texture.texture = player.image

func start_timer():
	if GameManager.players[index].score > 0:
		timer_on = true
