extends Control

func _ready() -> void:
	#set_result(3)
	pass
	
func hideA():
	$AnimationPlayer.play("RESET")
	$"1/4".visible = false
	$"2/4".visible = false
	$"3/4".visible = false

var x_map_id = 0

func set_result(score:int,map_id:int):
	x_map_id = map_id
	if map_id<4:
		$Label.text = "TUTORIAL "+str(map_id+1)
	else:
		$Label.text = "LEVEL "+str(map_id-3)
	$AnimationPlayer.play("wchodzi")
	
	await $AnimationPlayer.animation_finished
	Maps.success[map_id] = score
	Maps.update()
	
	if score >= 1:
		$"1/CPU".emitting = true
		$"1/4".visible = true
		$g1.play()
		await get_tree().create_timer(0.5).timeout
	if score >= 2:
		$"2/CPU".emitting = true
		$"2/4".visible = true
		$g2.play()
		await get_tree().create_timer(0.5).timeout
	if score == 3:
		$"3/CPU".emitting = true
		$"3/4".visible = true
		$g3.play()
		await get_tree().create_timer(0.5).timeout

func _on_mapy_pressed() -> void:
	Transition.change_scene(preload("res://stage_select.tscn"))
	Player.play("menu")

func _on_next_pressed() -> void:
	if x_map_id < 13:
		Maps.next_map()
	else:
		Transition.change_scene(preload("res://stage_select.tscn"))
		Player.play("menu")	
	
