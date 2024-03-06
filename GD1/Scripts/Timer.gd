extends RichTextLabel

signal RoundCommit()
signal NewRound()
signal IsPaused()
signal IsNotPaused()

var DisplayedText:int = 0
var DisplayedTextBig:int = 5

var NotPaused:bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var PauseTicker:int = 0
func _unhandled_input(event):
	
	if event is InputEventKey and event.pressed: 
		match event.keycode: #Find the correct key input
			### Sword Movement
			KEY_ESCAPE:
				PauseTicker += 1
				if (PauseTicker % 2) != 0:
					NotPaused = false
					emit_signal("IsPaused")
				else:
					NotPaused = true
					emit_signal("IsNotPaused")

func _TimerCycler(RoundTimeLimit, TimerTickSpeed):
	
	await get_tree().create_timer(TimerTickSpeed).timeout
	
	if DisplayedTextBig == 0 and DisplayedText == 0 and NotPaused:
		DisplayedTextBig = RoundTimeLimit
		emit_signal("RoundCommit")
		await get_tree().create_timer(2.5).timeout
		self.bbcode_text = "[bgcolor=#0000009f][center]" + "[/center][/bgcolor]"
		emit_signal("NewRound")
	
	if NotPaused:
		if DisplayedText == 0:
			DisplayedText = 9
			DisplayedTextBig -=1
		else:
			DisplayedText -= 1
		
	self.bbcode_text = "[bgcolor=#0000009f][center]" + str(DisplayedTextBig) + "." + str(DisplayedText) + "[/center][/bgcolor]"
	
	
	_TimerCycler(RoundTimeLimit, TimerTickSpeed)


func _on_base_higher_order_pause():
	PauseTicker += 1
	if (PauseTicker % 2) != 0:
		NotPaused = false
		emit_signal("IsPaused") # Replace with function body.
