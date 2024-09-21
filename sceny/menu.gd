extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for butt in $buttons.get_children():
		butt.pressed.connect(menu.bind(butt.name))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func menu(button_name:String) -> void:
	match(button_name):
		"start":
			Maps.next_map()
		"options":
			pass
		"about":
			pass	
