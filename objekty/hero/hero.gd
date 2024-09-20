extends RigidBody2D

var clicked = false
var gravity_act = false

@onready var arrow = Arrow
@onready var cosek = Cosek

func on_change_gravity(is_active):
	gravity_act = is_active
	gravity_scale = 0 if is_active else 1

func _ready() -> void:
	mouse_entered.connect(is_border.bind(true))
	mouse_exited.connect(is_border.bind(false))
	input_event.connect(_on_input_event)
	
func is_border(is_border):
	var value = 7 if is_border else 0
	$Icon.material.set_shader_parameter("is_active", is_border)
	$Icon.material.set_shader_parameter("thickness", value)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if gravity_act and event is InputEventMouseButton:
		var evbt:InputEventMouseButton = event
		if evbt.is_pressed() and evbt.button_index == MOUSE_BUTTON_LEFT:
			arrow.visible = true
			arrow.global_position = global_position
			Cosek.update_cosek_effect(global_position)
			clicked = true
			
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and clicked and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:	
		clicked = false
		arrow.visible = false
		Cosek.disable_effect()
		var dir = arrow.global_position.direction_to(get_global_mouse_position())
		var pow_fact = 150 if gravity_act else 10
		apply_central_force(dir * arrow.get_val() * pow_fact)
		
func _process(delta: float) -> void:
	if clicked:
		Cosek.update_cosek_effect(global_position)
		arrow.global_position = global_position
		var mouse_pos = get_global_mouse_position()
		arrow.look_at(mouse_pos)	
		var dist = arrow.global_position.distance_to(mouse_pos)
		arrow.set_val(dist/2)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		Transition.restart()
