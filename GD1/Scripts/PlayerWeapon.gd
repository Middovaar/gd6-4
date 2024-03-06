extends Sprite2D

@export_range(-1,1, 1.0) var WeaponPositionHigh:float # Is the weapon held at the high or low position?
@export var ThisIsA:StringName

var SwordPosition1 = Vector2(440, -170)
var SwordPosition0 = Vector2(440, 15)
var SwordPositionN1 = Vector2(440, 200)

var ShieldPosition1 = Vector2(-150, -170)
var ShieldPosition0 = Vector2(-150, 15)
var ShieldPositionN1 = Vector2(-150, 200)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_knight_player_position_shift(ShieldPosition, SwordPosition):
	if ThisIsA == "Sword":
		match SwordPosition:
			1:
				set_position(SwordPosition1)
			0:
				set_position(SwordPosition0)
			-1:
				set_position(SwordPositionN1)
			_:
				pass
				
	if ThisIsA == "Shield":
		match ShieldPosition:
			1:
				set_position(ShieldPosition1)
			0:
				set_position(ShieldPosition0)
			-1:
				set_position(ShieldPositionN1)
			_:
				pass
	
	pass
