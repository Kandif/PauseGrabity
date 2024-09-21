extends Node2D

@onready var main_music = $AudioStreamPlayer

var index = 0

func play_gravity():
	var tween = get_tree().create_tween()
	tween.parallel().tween_method(set_volume_gravity,-40,0,0.2)
	tween.parallel().tween_method(set_volume_main,0,-60,0.2)
	
	
func back_gravity():
	var tween = get_tree().create_tween()
	tween.parallel().tween_method(set_volume_gravity,0,-60,0.2)
	tween.parallel().tween_method(set_volume_main,-60,0,0.2)
	
	
func set_volume_main(vol:float) -> void:
	main_music.stream.set_sync_stream_volume(0,vol)
	
func set_volume_gravity(vol:float) -> void:
	main_music.stream.set_sync_stream_volume(1,vol)	
