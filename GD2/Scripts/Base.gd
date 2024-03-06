extends Node2D


@onready var wierdLevel = preload("res://GD2/Levels/WierdLevel.res").instantiate()
@onready var spikesLevel = preload("res://GD2/Levels/SpikeLevel.res").instantiate()
@onready var normalLevel = preload("res://GD2/Levels/NormalLevel.res").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_what_level_to_queue_free(LevelToRelieve):
	match LevelToRelieve:
		"normal":
			remove_child($NormalLevel)
		"wierd":
			remove_child($WierdLevel)
		"spikes":
			remove_child($SpikeLevel)
		_:
			pass


func _on_level_changer(LevelWeGoingTo):
	
	match LevelWeGoingTo:
		"normal":
			add_child(normalLevel)

		"wierd":
			"goto wierd"
			add_child(wierdLevel)

		"spikes":
			"goto spikes"
			add_child(spikesLevel)

		_:
			pass

func _on_normal_level_spike_level_change():
	%Player.position = Vector2(-20, -280)
	_on_what_level_to_queue_free("normal")
	_on_level_changer("spikes")

func _on_player_spikes_level_changer():
	%Player.position = Vector2(2560/2 - 150, 200)
	_on_what_level_to_queue_free("spikes")
	_on_level_changer("wierd")
