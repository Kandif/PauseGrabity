extends Node2D

var succes = preload("res://grafiki/transition/completed.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = 0
	for map in Maps.success:
		if map > 0 and index<13:
			$maps.get_child(index+1).disabled = false
			$maps.get_child(index).disabled = false
			$maps.get_child(index).texture_normal = succes
			if map == 3:
				for star in	$maps.get_child(index).get_children():
					star.get_child(0).visible = true
			elif map == 2:
				$maps.get_child(index).get_child(0).get_child(0).visible = true		
				$maps.get_child(index).get_child(1).get_child(0).visible = true		
			else:
				$maps.get_child(index).get_child(0).get_child(0).visible = true
		elif index == 13 and map > 0 :
			$maps.get_child(index).disabled = false
			$maps.get_child(index).texture_normal = succes
			if map == 3:
				for star in	$maps.get_child(index).get_children():
					star.get_child(0).visible = true
			elif map == 2:
				$maps.get_child(index).get_child(0).get_child(0).visible = true		
				$maps.get_child(index).get_child(1).get_child(0).visible = true		
			else:
				$maps.get_child(index).get_child(0).get_child(0).visible = true
		index += 1
				
	for map:TextureButton in $maps.get_children():
		map.pressed.connect(selected.bind(map.name.to_int()))
	
func selected(map_name):
	Maps.select_map(map_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	Transition.change_scene(load("res://sceny/menu.tscn"))


func _on_menu_pressed() -> void:
	Transition.change_scene(load("res://sceny/menu.tscn"))
