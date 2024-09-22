extends Control

const SAVE_FILE_PATH = "user://savedata.save"
const score_text = "SCORE: "
const high_score_text = "HIGH SCORE: "

func _ready():
	loada()
	
var data = {
	"sfx" : 0.5,
	"music" : 0.5
}:
	set(value):
		data = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"),linear_to_db(data.sfx))
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"),linear_to_db(data.music))
		$VBoxContainer/music.value = data.music
		$VBoxContainer/sounds.value = data.sfx

func loada():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var load_data = FileAccess.open_encrypted_with_pass(SAVE_FILE_PATH,FileAccess.READ,"cokolwiek")
		var content = JSON.parse_string(load_data.get_as_text())
		data = content
		load_data.close()
		
func savea():
	var save_data = FileAccess.open_encrypted_with_pass(SAVE_FILE_PATH,FileAccess.WRITE,"cokolwiek")
	save_data.store_string(JSON.stringify(data))
	save_data.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_music_value_changed(value: float) -> void:
	data.music = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"),linear_to_db(value))
	savea()


func _on_sounds_value_changed(value: float) -> void:
	data.music = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"),linear_to_db(value))
	savea()


func _on_button_pressed() -> void:
	$AnimationPlayer.play_backwards("wchodzi")
