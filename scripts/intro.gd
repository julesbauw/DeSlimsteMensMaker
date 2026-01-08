extends Node2D

@onready var next_scene:PackedScene = load("res://scenes/game.tscn")

const SCENE_TIME = 22.2

var time

func _ready() -> void:
    time = SCENE_TIME


func to_next_scene():
    get_tree().change_scene_to_packed(next_scene)

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("pas"):
        to_next_scene()


func _process(delta: float) -> void:
    time -= delta
    if time < 0:
        to_next_scene()
