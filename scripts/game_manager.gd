extends Node


var GAME_NAME

var players 


func _ready() -> void:
    reset()


func reset():
    GAME_NAME = ""
    players = []

