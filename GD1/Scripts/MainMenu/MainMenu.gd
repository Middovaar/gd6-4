extends Node2D

signal DesireFader()
signal StartGame()
signal Exit()

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayMusic()


func PlayMusic():
	if !%MainMenuMusic.is_playing():
		%MainMenuMusic.play()
	else:
		pass
	await get_tree().create_timer(0.3).timeout
	PlayMusic() 


func _on_play_button_pressed(ButtonName):
	%PlayClick.play()
	%PlayClick2.play()
	print(ButtonName)
	emit_signal("DesireFader")

func _on_controls_button_pressed(ButtonName):
	%ControlClick.play()

func _on_exit_button_pressed(ButtonName):
	%ExitClick.play()
	emit_signal("Exit")

func _on_blackfader_fader_done():
	emit_signal("StartGame")
