extends Sprite2D

const ScreenPosition:Array = [-930, 970, 2850]
var CurrentScreenPosition:int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = ScreenPosition[0]
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	pass

func _on_teleporters_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):

	if body is CharacterBody2D and local_shape_index == 0 and CurrentScreenPosition != 2:
		CurrentScreenPosition += 1
		position.x = ScreenPosition[CurrentScreenPosition]

	if body is CharacterBody2D and local_shape_index == 1 and CurrentScreenPosition != 0:
		CurrentScreenPosition -= 1
		position.x = ScreenPosition[CurrentScreenPosition]

	match CurrentScreenPosition:
		0:
			%LWorldBorder.position.x = -468
			%RWorldBorder.position.x = 1920
		1:
			%LWorldBorder.position.x = -468
			%RWorldBorder.position.x = 2777
		2:
			%LWorldBorder.position.x = 0
			%RWorldBorder.position.x = 2777
