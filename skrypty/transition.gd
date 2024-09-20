extends CanvasLayer

signal changed_scene

var is_playing = false
var changed = false

var scene_path:Object

func change_scene(xscene_path:Object) -> void:
	scene_path = xscene_path
	$AnimationPlayer.play("transition")
	changed = false
	is_playing = true
	
func restart() -> void:
	scene_path = null
	$AnimationPlayer.play("transition")
	changed = false
	is_playing = true

func _process(delta: float) -> void:
	if is_playing:
		if $AnimationPlayer.current_animation_position > 0.5 and !changed:
			changed = true
			is_playing = false
			changed_scene.emit()
			changing()

func changing():
	if scene_path == null:
		get_tree().reload_current_scene()
	else:	
		get_tree().change_scene_to_packed(scene_path)
