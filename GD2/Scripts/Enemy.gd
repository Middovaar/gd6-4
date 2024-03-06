extends CollisionShape2D

var Position:Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	Position = self.position # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var GoUp:bool
	self.position = Position
	
	if Position.x < 760 and GoUp:
		Position.x += 2
	else:
		GoUp = false
		
	if Position.x > 25 and !GoUp:
		Position.x -= 2
	else:
		GoUp = true
