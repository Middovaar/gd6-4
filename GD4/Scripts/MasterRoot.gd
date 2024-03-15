extends Node2D

@onready var Minigames = preload("res://GD4/Levels/Minigames.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gd_4_base_first_section_done():
	$Gd4Base.queue_free()
	add_child(Minigames)
