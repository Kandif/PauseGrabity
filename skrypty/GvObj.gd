extends Node

var object:Node2D:
	set(value):
		if object == null || value == null:
			object  = value
			if value!=null:
				foucs_object(object)
			else:
				Cosek.disable_effect()
		elif object != null and value!=null:
			var dist1 = value.global_position.distance_to(value.get_global_mouse_position())
			var dist2 = object.global_position.distance_to(object.get_global_mouse_position())
			if dist1<dist2:
				object.clicked = false
				object = value
				foucs_object(object)


func foucs_object(object):
	Arrow.visible = true
	Arrow.global_position = object.global_position
	Cosek.update_cosek_effect(object.global_position)				
				
func get_object() -> Object:
	return object
