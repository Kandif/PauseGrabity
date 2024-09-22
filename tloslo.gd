extends CanvasLayer

var tloski = [
	preload("res://grafiki/tlo/bg_green.png"),
	preload("res://grafiki/tlo/bg_red.png")
]

@export var id:int = 1:
	set(value):
		id = value
		match(id):
			2:
				$tlo.texture = tloski[0]
			3:
				$tlo.texture = tloski[1]	



func _ready() -> void:
	match(id):
		2:
			$tlo.texture = tloski[0]
		3:
			$tlo.texture = tloski[1]	
