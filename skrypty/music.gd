extends Node2D

@onready var main_music:AudioStreamPlayer = $main
@onready var tutorial:AudioStreamPlayer = $tutorial
@onready var menu:AudioStreamPlayer = $menu
@onready var pause:AudioStreamPlayer = $pausa

var before_pause = ""

var index = 0
var last_music = ""

#func _ready() -> void:
	#play("tutorial")
	
func play_next():
	$next_level.play()

func play_lose():
	$lose.play()
	
func play_win():
	$win.play()
	
func play_muszla():
	$muszla.play()	
	
func play_wrog():
	$rzut_wrogiem.pitch_scale = randf_range(0.5,1.5)
	$rzut_wrogiem.play()
	
func play(music_name:String):
	if music_name == "before":
		music_name = before_pause
	if last_music != music_name:
		var tween = get_tree().create_tween()
		tween.parallel().tween_property(main_music,"volume_db",-80,0.2)
		tween.parallel().tween_property(tutorial,"volume_db",-80,0.2)
		tween.parallel().tween_property(menu,"volume_db",-80,0.2)
		tween.parallel().tween_property(pause,"volume_db",-80,0.2)
		if music_name != "pause":
			await tween.finished
		tween = get_tree().create_tween()
		match(music_name):
			"main":
				main_music.play()
				tween.tween_property(main_music,"volume_db",0,0.2)
				tutorial.stop()
				menu.stop()
				pause.stop()
			"tutorial":
				tutorial.play()
				tween.tween_property(tutorial,"volume_db",0,0.2)
				main_music.stop()
				menu.stop()
				pause.stop()
			"menu":
				menu.play()
				tween.tween_property(menu,"volume_db",0,0.2)
				main_music.stop()
				tutorial.stop()
				pause.stop()
			"pause":
				before_pause = last_music
				pause.play()
				pause.volume_db = 0
				main_music.stop()
				tutorial.stop()
				menu.stop()	
		last_music = music_name		


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
