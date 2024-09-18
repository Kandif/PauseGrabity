extends Area2D

const SPEED = 500
@onready var effect_rect = $"../ColorRect"
var is_gravity_paused = false

@onready var timer = $pause_gravity_timer

var factor = 0:
	set(value):
		factor = value
		effect_rect.material.set_shader_parameter("factor",factor)
		


func _physics_process(delta: float) -> void:
	if !timer.is_stopped():
		$circle_timer.value = timer.time_left * 20
	
	var mouse_pos = get_global_mouse_position()
	if global_position.distance_to(mouse_pos)>5:
		global_position = global_position.move_toward(mouse_pos,SPEED)
		
	if Input.is_action_just_pressed("pause_gravity") and !is_gravity_paused:
		is_gravity_paused = true
		for object in get_tree().get_nodes_in_group("gravity"):
			object.on_change_gravity(true)
		var simple_tween = get_tree().create_tween()
		simple_tween.tween_property(effect_rect.material,"shader_parameter/radius",2.5,1.5)
		#simple_tween.tween_method(func(value): effect_rect.material.set_shader_parameter("RADIUS", value), 0, 1.93,0.5)
		$"../CPUParticles2D".emitting = true
		$circle_timer.visible = true
		timer.start()
	elif Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func _on_pause_gravity_timer_timeout() -> void:
	$circle_timer.visible = false
	is_gravity_paused = false
	var simple_tween = get_tree().create_tween()
	simple_tween.tween_property(effect_rect.material,"shader_parameter/radius",0,0.5)
	for object in get_tree().get_nodes_in_group("gravity"):
		object.on_change_gravity(false)
