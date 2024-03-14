extends NinePatchRect

const Invisible = Color.TRANSPARENT
const Visible = Color.ANTIQUE_WHITE

var Selected:bool
signal No()
signal Yes()

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Invisible
	$Yes.text = "[center]> Yes <[/center]"
	$No.text = "[center]No[/center]"

func _on_show_yes_no():
	modulate = Visible
	Selected = true
	

func _input(event):
	if modulate == Visible and Input.is_action_just_pressed("Back") or Input.is_action_just_pressed("Forward"):
		Selected = not Selected
		Selector(Selected)
	
	if Input.is_action_just_pressed("Jump") and modulate == Visible:
		if Selected:
			pass
			emit_signal("No")
			emit_signal("Yes")
			modulate = Invisible
			
		else:
			$Yes.text = "[center]> Yes <[/center]"
			$No.text = "[center]No[/center]"
			emit_signal("No")
			modulate = Invisible
			

func Selector(Selected):
	match Selected:
		true:
			$Yes.text = "[center]> Yes <[/center]"
			$No.text = "[center]No[/center]"
		false:
			$Yes.text = "[center]Yes[/center]"
			$No.text = "[center]> No <[/center]"
