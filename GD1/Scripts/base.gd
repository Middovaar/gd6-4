extends Node2D

signal HigherOrderPause()
signal BackToMainMenu()

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("HigherOrderPause")
	

func _unhandled_input(event):
	if event is InputEventKey and event.pressed: 
		match event.keycode: #Find the correct key input
			### Sword Movement
			KEY_Z:
				emit_signal("BackToMainMenu")
				

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
