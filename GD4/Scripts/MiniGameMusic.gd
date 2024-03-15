extends Node2D

var ActiveTyping:int
var TypeChecker:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$FirstPeriod.play()

func _process(delta):
	if TypeChecker:
		PlayKeboardSounds()
	else:
		if $KeboardSounds.is_playing():
			$KeboardSounds.stop()

func _on_first_period_finished():
	$FirstPeriod.play()


func _on_minigames_cut_minigame_sound():
	$FirstPeriod.stop()


func _input(event):
	if event is InputEventKey and event.is_pressed():
		TypeChecker = true
	if event is InputEventKey and event.is_released():
		await get_tree().create_timer(0.7).timeout
		TypeChecker = false

func PlayKeboardSounds():
	if !$KeboardSounds.is_playing():
		$KeboardSounds.play()
	else:
		pass
