extends Sprite2D

var sindisplacement:float
var colourcounter:float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	const counter = 2*PI
	
	if sindisplacement < counter:
		sindisplacement = 0.04 + sindisplacement
	else:
		sindisplacement = 0
	
	self.position.y = 680 + 30 * -sin(sindisplacement)
	
	
	if colourcounter < 1:
		colourcounter = 0.004 + colourcounter
	else:
		colourcounter = 0
	
	set_self_modulate(Color.from_hsv(colourcounter, 0.5, 1, 1))
