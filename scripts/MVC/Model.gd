extends Resource

class_name Model

var listeners:Array[Listener]


func _init() -> void:
	listeners = []

func _update_listeners():

	for listener in listeners:
		listener.update()

func add_listener(listener:Listener):
	listener.model = self
	listeners.append(listener)

func remove_listener(listener:Listener):
	listeners.erase(listener)
