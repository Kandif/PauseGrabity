extends Node2D

var succes = preload("res://grafiki/transition/completed.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = 0
	for map in Maps.success:
		index += 1
		if map > 0:
			$maps.get_child(index).disabled = false
			$maps.get_child(index-1).texture_normal = succes
			if map == 3:
				for star in	$maps.get_child(index-1).get_children():
					star.get_child(0).visible = true
			elif map == 2:
				$maps.get_child(index-1).get_child(0).get_child(0).visible = true		
				$maps.get_child(index-1).get_child(1).get_child(0).visible = true		
			else:
				$maps.get_child(index-1).get_child(0).get_child(0).visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
