extends RichTextLabel

signal ButtonPressed(ButtonName)

@export var ButtonName:String



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("ButtonPressed", ButtonName)


func _on_mouse_entered():
	self.set_self_modulate(Color8(255, 255, 0, 255))
	%MenuOpenDismiss.play()


func _on_mouse_exited():
	self.set_self_modulate(Color8(255, 255, 255, 255)) 
