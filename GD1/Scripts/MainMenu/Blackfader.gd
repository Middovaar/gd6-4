extends Sprite2D

var opacity:int = 0
var fader:bool = false

signal FaderDone()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fader:
		self.set_self_modulate(Color8(255, 255, 255, opacity))
		if opacity < 254:
			opacity += 4
	
	if opacity >= 254:
		emit_signal("FaderDone")

func _on_main_menu_desire_fader():
	fader = true
