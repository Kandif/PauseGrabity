extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var tween = get_tree().create_tween()
		tween.tween_property($Icon,"scale",Vector2(0,0),0.5)
		body.win()
		#Player.back_gravity()
		#Maps.next_map()
		Player.play_win()
		var ilosc = Cosek.licznik
		var star2 = $"../UI".star2 >= ilosc
		var star3 = $"../UI".star3 >= ilosc
		$"../ColorRect".visible = false
		var map_id = $"../UI".id_map
		if star3:
			Result.set_result(3,map_id)
		elif star2:
			Result.set_result(2,map_id)	
		else:
			Result.set_result(1,map_id)	
