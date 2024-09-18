extends Node2D

func set_val(val:float) -> void:
	$TextureProgressBar.value = val

func get_val() -> float:
	return $TextureProgressBar.value
