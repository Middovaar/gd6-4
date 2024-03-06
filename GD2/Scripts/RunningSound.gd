extends AudioStreamPlayer

var OriginalVolume:float
var CurrentVolume:float

# Called when the node enters the scene tree for the first time.
func _ready():
	play()
	OriginalVolume = get_volume_db()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_running_sound():
	if CurrentVolume < -12:
		CurrentVolume += 1
	else:
		pass
	set_volume_db(CurrentVolume)

func _on_finished():
	play() 


func _on_player_stop_running():
	CurrentVolume = OriginalVolume
	set_volume_db(OriginalVolume) # Replace with function body.
