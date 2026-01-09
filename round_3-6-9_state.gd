extends RoundStateUI


const QUESTION_FILE_NAME = "vragen.txt"

const MAX_QUESTIONS = 15

const MARGIN_SIZE = 100

const POINTS = 10

var vragen:Array[String]

var current_question

@export var question_list:HBoxContainer

@export var question_label:Label

var passed_players = []

var question_round_number: Array[RoundNumber]

var round_number_scene:PackedScene = load("res://scenes/round_number.tscn")

func _ready() -> void:
	super._ready()
	vragen = FileParser.parse_question_file(round_directory + "/" + QUESTION_FILE_NAME)
	question_label.text = ""

func enter_state():
	super.enter_state()
	passed_players = []
	
	current_question = -1

	_first_player()

	for i in range(len(vragen)):        
		var scene := round_number_scene.instantiate() as RoundNumber

		var margin := MarginContainer.new()

		if scene == null:
			return

		var m = MARGIN_SIZE
		if i % 2 == 0:
			m = 0

		margin.add_theme_constant_override("margin_top",m)

		margin.add_child(scene)


		scene.set_number_label(i + 1)
		question_round_number.append(scene)

		question_list.add_child(margin)

## game Logic

func handle_input(event:InputEvent):

	if current_question >= len(vragen):
		return

	if event.is_action_pressed("pas"):
		get_state_machine().wrong_audio.play()
		passed_players.append(GameManager.current_player)
		_next_player()

	if event.is_action_pressed("correct"):
		get_state_machine().correct_audio.play()
		GameManager.players[GameManager.current_player].score += POINTS
		next_question()


func next_question():
	passed_players.clear()
	if current_question >= 0:
		question_round_number[current_question].toggle_off()
	
	current_question += 1
	if current_question < len(vragen) and current_question < MAX_QUESTIONS:
		question_label.text = vragen[current_question]
		question_round_number[current_question].toggle_on()
	else:
		current_question = min(len(vragen),MAX_QUESTIONS) - 1

func _first_player():
	GameManager.current_player = 0

	get_state_machine().player_list[GameManager.current_player].select(false)

func _next_player():

	get_state_machine().player_list[GameManager.current_player].deselect()

	GameManager.current_player = (GameManager.current_player + 1) % len(GameManager.players)


	get_state_machine().player_list[GameManager.current_player].select(false)

	if len(passed_players) == len(GameManager.players):
		next_question()


func answer_correct():

	get_state_machine().correct_audio.play()

	
