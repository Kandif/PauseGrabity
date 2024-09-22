extends Node

var actual_map = 0

var success = [3,2,1,0,
0,0,0,0,
0,0,0,0,
0,0,0,0,
0,0,0]

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

var keys = [KEY_1,KEY_2,KEY_3,KEY_4,KEY_5,KEY_6,KEY_7,KEY_8,KEY_9,KEY_0]

func _ready() -> void:
	Player.play("tutorial")

func _process(delta: float) -> void:
	for input in keys:
		if Input.is_key_pressed(input):
			select_map(keys.find(input)+5)

func next_map() -> void:
	actual_map += 1
	if actual_map<4:
		Player.play("tutorial")
	else:
		Player.play("main")	
	Transition.change_scene(maps[actual_map])
	
func select_map(index:int) -> void:
	actual_map = index-1
	if actual_map<4:
		Player.play("tutorial")
	else:
		Player.play("main")	
	Transition.change_scene(maps[actual_map])
	
