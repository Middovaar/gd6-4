extends Sprite2D

const Visible = Color.BLACK
const Invisible = Color.TRANSPARENT

var CurrentAlpha = 0
var CurrentlyFading:bool = false
var FadeToBlack:bool = false

var LeaveBase:bool = false

signal IsBlack()
signal IsBlackTransition()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if CurrentlyFading and FadeToBlack:
		CurrentAlpha += 5
		modulate = Color8(0,0,0, int(CurrentAlpha))
		
	if CurrentlyFading and !FadeToBlack:
		CurrentAlpha -= 5
		modulate = Color8(0,0,0, CurrentAlpha)
		
	if modulate == Visible and !LeaveBase:
		FadeToBlack = false
		emit_signal("IsBlack")
	if modulate == Visible and LeaveBase:
		emit_signal("IsBlackTransition")

func _on_yes():
	CurrentlyFading = true
	FadeToBlack = true

func _on_dialogue_box_base_leave_base():
	CurrentAlpha = 0
	CurrentlyFading = true
	FadeToBlack = true
	LeaveBase = true
