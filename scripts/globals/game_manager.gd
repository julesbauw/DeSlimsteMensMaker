extends Node


var GAME_NAME

var players:Array[Player]

const GAMES_DIR := "user://games"

var current_player = 0

func _ready() -> void:
    reset()


func reset():
    GAME_NAME = ""
    players = []
    current_player = 0




