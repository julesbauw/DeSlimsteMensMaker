extends StateMachineUI


@export var correct_audio:AudioStreamPlayer2D
@export var wrong_audio:AudioStreamPlayer2D
@export var stop_clock_audio:AudioStreamPlayer2D

@export var clock_audio:AudioStreamPlayer2D

@export var player_list:HBoxContainer


@onready var player_ui_scene:PackedScene = load("res://scenes/player_ui.tscn")


func _ready() -> void:
	super._ready()
	for i in range(len(GameManager.players)):
		var player_ui = player_ui_scene.instantiate() as PlayerUI
		player_ui.set_player(i)
		player_list.add_child(player_ui)

func _on_skip_round():
	if current_state == null || not (current_state is RoundStateUI):
		return
	var round_state:RoundStateUI = current_state as RoundStateUI
	round_state.skip_round()

func _on_skip_question():
	if current_state == null || not (current_state is RoundStateUI):
		return
	var round_state:RoundStateUI = current_state as RoundStateUI
	round_state.next_question()

func play_correct_audio():
	correct_audio.play()

func play_wrong_audio():
	wrong_audio.play()

func play_stop_clock_audio():
	stop_clock_audio.play()

func start_clock_audio():
	clock_audio.play()

func end_clock_audio():
	clock_audio.stop()
