extends Area2D

const SPEED = 50

var effect_rect
var particle

var is_gravity_paused = false

var licznik = 0

@onready var timer = $pause_gravity_timer

var ob_pos:Vector2
var final_pos:Vector2 
var is_pushing = false
var angle = 0

var factor = 0:
	set(value):
		factor = value
		effect_rect.material.set_shader_parameter("factor",factor)
		
func update_cosek_effect(pos:Vector2):
	ob_pos = pos
	is_pushing = true
	
func disable_effect():
	is_pushing = false
	
func restart():
	licznik = 0
	if is_gravity_paused:
		Player.back_gravity()
		$tyk.stop()
		$graw.stop()
	$circle_timer.value = 100
	$circle_timer.visible = false
	is_gravity_paused = false
	is_pushing = false
	timer.stop()
	if effect_rect!= null:
		var simple_tween = get_tree().create_tween()
		simple_tween.tween_property(effect_rect.material,"shader_parameter/radius",0,0.5)

func _physics_process(delta: float) -> void:
	if !is_gravity_paused and $circle_timer.value<100:
		$circle_timer.value += 75 * delta
	
	angle += delta * 360
	if angle>=360:
		angle = 0
	
	if !timer.is_stopped():
		$circle_timer.value = timer.time_left * 20
	
	if !is_pushing:
		var mouse_pos = get_global_mouse_position()
		if global_position.distance_to(mouse_pos)>5:
			global_position = global_position.move_toward(mouse_pos,SPEED)		
	else:
		final_pos = ob_pos + Vector2.RIGHT.rotated(deg_to_rad(angle)) * 100
		global_position = global_position.move_toward(final_pos,SPEED)
		
	if effect_rect!= null and Input.is_action_just_pressed("pause_gravity") and !is_gravity_paused and $circle_timer.value == 100:
		Player.play_gravity()
		licznik += 1
		$tyk.play()
		$graw.play()
		is_gravity_paused = true
		for object in get_tree().get_nodes_in_group("gravity"):
			object.on_change_gravity(true)
		var simple_tween = get_tree().create_tween()
		effect_rect.material.set_shader_parameter("centerr",get_global_mouse_position())
		simple_tween.tween_property(effect_rect.material,"shader_parameter/radius",2.5,1.5)
		#simple_tween.tween_method(func(value): effect_rect.material.set_shader_parameter("RADIUS", value), 0, 1.93,0.5)
		particle.global_position = global_position
		particle.emitting = true
		$circle_timer.visible = true
		timer.start()
	elif Input.is_action_just_pressed("restart"):
		Transition.restart()

func _on_pause_gravity_timer_timeout() -> void:
	Player.back_gravity()
	#$circle_timer.visible = false
	is_gravity_paused = false
	var simple_tween = get_tree().create_tween()
	simple_tween.tween_property(effect_rect.material,"shader_parameter/radius",0,0.5)
	for object in get_tree().get_nodes_in_group("gravity"):
		object.on_change_gravity(false)
