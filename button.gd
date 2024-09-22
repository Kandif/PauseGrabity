extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation_degrees = randf_range(0,360)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += 5 * delta
	for star in get_children():
		star.rotation_degrees += 30 * delta
