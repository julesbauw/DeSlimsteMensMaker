extends StateUI

class_name RoundStateUI

var next_round_name:String

var round_directory:String

@export var round_name:String

func _ready() -> void:
    round_directory = GameManager.GAMES_DIR + "/" + GameManager.GAME_NAME + "/" + round_name

func skip_round():
    state_machine.switch_state(next_round_name)

func next_question():
    pass



