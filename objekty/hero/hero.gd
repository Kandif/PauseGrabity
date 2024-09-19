extends RigidBody2D

var clicked = false
var gravity_act = false

@onready var arrow = Arrow

func on_change_gravity(is_active):
	gravity_act = is_active
	gravity_scale = 0 if is_active else 1

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var evbt:InputEventMouseButton = event
		if evbt.is_pressed() and evbt.button_index == MOUSE_BUTTON_LEFT:
			arrow.visible = true
			arrow.global_position = global_position
			clicked = true
			
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and clicked and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:	
		clicked = false
		arrow.visible = false
		var dir = arrow.global_position.direction_to(get_global_mouse_position())
		var pow_fact = 100 if gravity_act else 10
		apply_central_force(dir * arrow.get_val() * pow_fact)
		
func _process(delta: float) -> void:
	if clicked:
		var mouse_pos = get_global_mouse_position()
		arrow.look_at(mouse_pos)	
		var dist = arrow.global_position.distance_to(mouse_pos)
		arrow.set_val(dist/2)
