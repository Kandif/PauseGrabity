extends RigidBody2D
class_name GravityObject

@onready var border = preload("res://skrypty/ob_border.gdshader")

var clicked = false
var gravity_act = false

@onready var arrow = Arrow

func on_change_gravity(is_active):
	gravity_act = is_active
	gravity_scale = 0 if is_active else 1
	var value = 0
	$Icon.material.set_shader_parameter("is_active", false)
	$Icon.material.set_shader_parameter("thickness", value)

func _ready():
	var materialx = ShaderMaterial.new()
	materialx.shader = border
	materialx.set_shader_parameter("is_active", false)
	materialx.set_shader_parameter("thickness", 0)
	materialx.set_shader_parameter("outline_color", Color("ffff99bc"))
	$Icon.material = materialx
	mouse_entered.connect(is_border.bind(true))
	mouse_exited.connect(is_border.bind(false))
	input_event.connect(_on_input_event)
	
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
			#arrow.visible = true
			#arrow.global_position = global_position
			#clicked = true
			
func _input(event: InputEvent) -> void:
		if event is InputEventMouseButton and clicked and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:	
			clicked = false
			arrow.visible = false
			GvObj.object = null
			var dir = arrow.global_position.direction_to(get_global_mouse_position())
			var pow_fact = 100 if gravity_act else 10
			apply_central_force(dir * arrow.get_val() * pow_fact)
			
func _process(delta: float) -> void:
	if clicked:
		arrow.global_position = global_position
		var mouse_pos = get_global_mouse_position()
		arrow.look_at(mouse_pos)	
		var dist = arrow.global_position.distance_to(mouse_pos)
		arrow.set_val(dist/2)
