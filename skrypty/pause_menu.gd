extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var bombelek = preload("res://objekty/bombelek.tscn")

var punkciki = 0

func penkanko(viewport:Node, event:InputEvent, shape_idx,bombelekx:Object):
	if event is InputEventMouseButton:
		var evbt:InputEventMouseButton = event
		if evbt.is_pressed() and evbt.button_index == MOUSE_BUTTON_LEFT:
			bombelekx.queue_free()
			punkciki += 1
			$Label.text = str(punkciki)

func _on_timer_timeout() -> void:
	var nowy_bombelek:RigidBody2D = bombelek.instantiate()
	add_child(nowy_bombelek)
	nowy_bombelek.input_event.connect(penkanko.bind(nowy_bombelek))
	nowy_bombelek.global_position = Vector2(randf_range(0,1920),1280+200)
	nowy_bombelek.gravity_scale = randf_range(-0.01,-0.3)
