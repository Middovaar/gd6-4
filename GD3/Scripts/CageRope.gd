extends NinePatchRect

var Wave:bool = false
var SineCounter:float = 0

var Val:float = 0
var SwingWeight:float = 10

# Called when the node enters the scene tree for the first time.

func _process(delta):
	
	SineCounter += 0.01
	
	if SineCounter >= TAU:
		SineCounter = 0
	
	if Wave:
		self.rotation = CageRopeSwing(self.rotation)
		SwingWeight = lerpf(SwingWeight, 3, 0.01)
		
	
	

func _on_character_body_2d_cage_destroyer_animation():
	
	Wave = true
	

func CageRopeSwing(Rotation:float) -> float: 
	
	
	Val = lerpf(self.rotation, deg_to_rad(sin(SineCounter*(2))*SwingWeight), 0.05)
	
	
	return Val
