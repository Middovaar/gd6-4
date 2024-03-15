extends Node2D

const LocationVolume = [float(0), float(-5), float(-10)]
var WhichRoomAreWeIn = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_first_period_roommusic_finished():
	$FirstPeriod.play


func _on_teleporters_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	$FirstPeriod.position = %MusicTracker.get_position()
	if local_shape_index == 0 and body is CharacterBody2D and WhichRoomAreWeIn <= 2:
		WhichRoomAreWeIn -= 1
	if local_shape_index == 1 and body is CharacterBody2D and WhichRoomAreWeIn >= 0:
		WhichRoomAreWeIn += 1
	
	$FirstPeriod.set_volume_db(LocationVolume[WhichRoomAreWeIn])
