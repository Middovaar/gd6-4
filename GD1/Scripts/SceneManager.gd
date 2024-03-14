extends Node2D


@onready var NextLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_main_menu_start_game():
	get_child(0).queue_free()
	NextLevel = preload("res://GD1/GD1Base.tscn").instantiate() 	
	add_child(NextLevel) #Adds the new level as a child
	NextLevel = $Base
	if NextLevel == $Base and NextLevel != null:
		NextLevel.BackToMainMenu.connect(_on_map_view_level_change)
		print("heyy!")

func _on_main_menu_exit():
	$MainMenu.queue_free()
	get_tree().quit(0)

func _on_map_view_level_change():
	$Base.queue_free()
	NextLevel = preload("res://GD1/MainMenu.tscn").instantiate() 
	add_child(NextLevel) #Adds the new level as a child
	NextLevel = null
