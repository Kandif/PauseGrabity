extends Node

var object:
	set(value):
		if object == null ||  value == null:
			object  = value

func get_object() -> Object:
	return object
