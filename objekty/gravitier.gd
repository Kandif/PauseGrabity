extends Area2D

var gravity_act = false

@onready var arrow = Arrow

func on_change_gravity(is_active):
	gravity_act = is_active
	monitoring = !is_active
	var tween = get_tree().create_tween()
	if is_active:
		tween.tween_property($Icon,"scale",Vector2(0,0),0.5)
	else:
		tween.tween_property($Icon,"scale",Vector2(0.31,0.31),0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += delta * -150
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("gravity"):
		$wir.play()
