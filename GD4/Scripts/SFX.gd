extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$VoiceSet.set_volume_db(-20)



func _on_voice_set_finished():
	$VoiceSet.play()
	print("hi")

func _on_dialogue_box_base_is_visible():
	$VoiceSet.play()
	print("hi")

func _on_dialogue_box_base_is_invisible():
	$VoiceSet.stop() # Replace with function body.
