extends RigidBody2D

var clicked = false
var gravity_act = false

var is_hidden = false
var landed = true

@onready var arrow = Arrow
@onready var cosek = Cosek

func on_change_gravity(is_active):
	gravity_act = is_active
	gravity_scale = 0 if is_active else 1
	var value = 0
	$Icon.material.set_shader_parameter("is_active", false)
	$Icon.material.set_shader_parameter("thickness", value)
	if is_active:
		is_hidden = true
		$Icon.play("hide")	
		$body.disabled = true
		lock_rotation = !is_active
		#$ray.enabled = false
		#await get_tree().create_timer(0.1).timeout
		#$ray.enabled = true
	else:
		var simple_tween = get_tree().create_tween()
		simple_tween.tween_property(self,"rotation_degrees",0,0.3)
		lock_rotation = !is_active
		is_hidden = true
		$Icon.play("hide_to_fall")	
		$body.disabled = true
		await $Icon.animation_finished
		$Icon.play("fall")
		landed = false

func _ready() -> void:
	$Area2D.mouse_entered.connect(is_border.bind(true))
	$Area2D.mouse_exited.connect(is_border.bind(false))
	$Area2D.input_event.connect(_on_input_event)
	
func is_border(is_border):
	if gravity_act:
		var value = 7 if is_border else 0
		$Icon.material.set_shader_parameter("is_active", is_border)
		$Icon.material.set_shader_parameter("thickness", value)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if gravity_act and event is InputEventMouseButton:
		var evbt:InputEventMouseButton = event
		if evbt.is_pressed() and evbt.button_index == MOUSE_BUTTON_LEFT:
			clicked = true
			GvObj.object = self
			
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and clicked and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:	
		clicked = false
		arrow.visible = false
		GvObj.object = null
		Cosek.disable_effect()
		var dir = arrow.global_position.direction_to(get_global_mouse_position())
		var pow_fact = 150 if gravity_act else 10
		apply_central_force(dir * arrow.get_val() * pow_fact)
		#if !is_hidden:
			
		
func _process(delta: float) -> void:
	#$test.rotation = -rotation
	if  !landed and !gravity_act and $test.is_on_floor and linear_velocity.length() < 10:
		landed = true
		$Icon.play("fall_to_idle")
		await $Icon.animation_finished
		$Icon.play("idle")
	
	#$ray.rotation = -rotation
	#if is_hidden and $ray.is_colliding():
		#is_hidden = false
		#$Icon.play_backwards("hide")
		#$body.disabled = false
		#var simple_tween = get_tree().create_tween()
		#simple_tween.tween_property(self,"rotation_degrees",0,0.1)
		
	if clicked:
		Cosek.update_cosek_effect(global_position)
		arrow.global_position = global_position
		var mouse_pos = get_global_mouse_position()
		arrow.look_at(mouse_pos)	
		var dist = arrow.global_position.distance_to(mouse_pos)
		arrow.set_val(dist/2)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		$Icon.modulate = Color.RED
		Transition.restart()
