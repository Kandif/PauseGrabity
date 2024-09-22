extends RigidBody2D

func penk():
	$AnimatedSprite2D.play("penk")
	await $AnimatedSprite2D.animation_finished
	queue_free()
	
func _process(delta: float) -> void:
	global_position.y += delta * 100
	

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
