extends Node2D

signal SpikeLevelChange

signal PushXPlayerPos(PlayerPositioninX)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_positionin_x(PlayerPositioninX):
	emit_signal("PushXPlayerPos", PlayerPositioninX)
	
	if PlayerPositioninX >= 2740:
		emit_signal("SpikeLevelChange")
