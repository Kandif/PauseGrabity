extends Area2D

var gravity_act = false

@onready var arrow = Arrow

func on_change_gravity(is_active):
	gravity_act = is_active
	monitoring = !is_active

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
