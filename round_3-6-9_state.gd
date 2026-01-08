extends RoundStateUI


const QUESTION_FILE_NAME = "vragen.txt"

const MAX_QUESTIONS = 15

const MARGIN_SIZE = 100

var vragen:Array[String]

var current_question


@export var question_list:HBoxContainer

@export var question_label:Label

var round_number_scene:PackedScene = load("res://scenes/round_number.tscn")

func _ready() -> void:
	super._ready()
	vragen = FileParser.parse_question_file(round_directory + "/" + QUESTION_FILE_NAME)
	current_question = -1
	question_label.text = ""
	print(len(vragen))

func enter_state():
	super.enter_state()

	for i in range(len(vragen)):        
		var scene := round_number_scene.instantiate() as RoundNumber

		var margin := MarginContainer.new()

		if scene == null:
			return

		var m = MARGIN_SIZE
		if i % 2 == 0:
			m = 0
		print(m)

		margin.add_theme_constant_override("margin_top",m)

		var btn := Button.new()
		btn.text = "Button %d" % i

		margin.add_child(scene)


		scene.set_number_label(i + 1)
		question_list.add_child(margin)

func leave_state():
	super.enter_state()

func next_question():
	current_question += 1
	if current_question < len(vragen):
		question_label.text = vragen[current_question]
