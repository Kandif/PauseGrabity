extends Node2D

@onready var main_music:AudioStreamPlayer = $main
@onready var tutorial:AudioStreamPlayer = $tutorial

var index = 0
var last_music = ""

#func _ready() -> void:
	#play("tutorial")
	
func play(music_name:String):
	if last_music != music_name:
		last_music = music_name
		var tween = get_tree().create_tween()
		tween.parallel().tween_property(main_music,"volume_db",-80,0.2)
		tween.parallel().tween_property(tutorial,"volume_db",-80,0.2)
		match(music_name):
			"main":
				main_music.play()
				tween.parallel().tween_property(main_music,"volume_db",0,0.2)
				await tween.finished
				tutorial.stop()
			"tutorial":
				tutorial.play()
				tween.parallel().tween_property(tutorial,"volume_db",0,0.2)
				await tween.finished
				main_music.stop()


func play_gravity():
	var tween = get_tree().create_tween()
	var funcc = set_volume_gravity if last_music=="main" else set_volume_gravityt
	var funcc2 = set_volume_main if last_music=="main" else set_volume_maint
	tween.parallel().tween_method(funcc,-40,0,0.2)
	tween.parallel().tween_method(funcc2,0,-60,0.2)
	
func back_gravity():
	var tween = get_tree().create_tween()
	var funcc = set_volume_gravity if last_music=="main" else set_volume_gravityt
	var funcc2 = set_volume_main if last_music=="main" else set_volume_maint
	tween.parallel().tween_method(funcc,0,-60,0.2)
	tween.parallel().tween_method(funcc2,-60,0,0.2)	
	
	

	
func set_volume_main(vol:float) -> void:
	main_music.stream.set_sync_stream_volume(0,vol)
	
func set_volume_gravity(vol:float) -> void:
	main_music.stream.set_sync_stream_volume(1,vol)	
	
func set_volume_maint(vol:float) -> void:
	tutorial.stream.set_sync_stream_volume(0,vol)
	
func set_volume_gravityt(vol:float) -> void:
	tutorial.stream.set_sync_stream_volume(1,vol)	
