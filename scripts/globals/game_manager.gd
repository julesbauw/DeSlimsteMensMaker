extends Node


var GAME_NAME

var players:Array[Player]

const GAMES_DIR := "user://games"


func _ready() -> void:
    reset()


func reset():
    GAME_NAME = ""
    players = []

