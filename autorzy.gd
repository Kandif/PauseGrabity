extends Node2D

var active =  false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func open():
	if !active:
		active = true
		$AnimationPlayer.play("autorzy")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$AnimationPlayer.play_backwards("autorzy")
		active = false
		
