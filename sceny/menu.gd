extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player.play("menu")
	
	for butt in $buttons.get_children():
		butt.button_up.connect(menu.bind(butt.name))

var scene = preload("res://stage_select.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func menu(button_name:String) -> void:
	match(button_name):
		"start":
			Transition.change_scene(scene)
		"options":
			pass
		"about":
			$Autorzy.open()
