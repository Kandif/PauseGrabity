extends CanvasLayer

signal changed_scene

var is_playing = false
var changed = false

var scene_path:String

func change_scene(xscene_path:String) -> void:
	scene_path = xscene_path
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
	get_tree().change_scene_to_file(scene_path)
