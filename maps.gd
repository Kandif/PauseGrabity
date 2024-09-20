extends Node

var actual_map = 0

var maps = [
	preload("res://sceny/maps/tutorial1.tscn"),
	preload("res://sceny/maps/tutorial2.tscn"),
	preload("res://sceny/maps/tutorial3.tscn"),
	preload("res://sceny/maps/tutorial4.tscn"),
	preload("res://sceny/maps/map1.tscn"),
	preload("res://sceny/maps/map2.tscn"),
	preload("res://sceny/maps/map3.tscn"),
	preload("res://sceny/maps/map4.tscn"),
	preload("res://sceny/maps/map5.tscn"),
	preload("res://sceny/maps/map6.tscn"),
	preload("res://sceny/maps/map7.tscn"),
	preload("res://sceny/maps/map8.tscn"),
	preload("res://sceny/maps/map9.tscn"),
	preload("res://sceny/maps/map10.tscn")
]

func next_map() -> void:
	actual_map += 1
	Transition.change_scene(maps[actual_map])
	
func select_map(index:int) -> void:
	actual_map = index-1
	Transition.change_scene(maps[actual_map])
	
