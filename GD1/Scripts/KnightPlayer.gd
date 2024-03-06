extends Sprite2D


signal PositionShift(ShieldPosition, SwordPosition)

signal RoundFinishIsAtPosition(ShieldPosition, SwordPosition)


### Screen Position, in case that is needed ###
var ScreenPosition

#### Weapon Position IDs ####
var ShieldPosition:int
var SwordPosition:int # The index of where we are, positionwize

@export var InputLock:bool # Input Lock, because an action is happening already


func _ready():
	ScreenPosition = get_global_position() #gets the self object position on canvas
	ShieldPosition = get_child(0).WeaponPositionHigh #gets the 1st child in the node tree, and its variable "WeaponPositionHigh"  - corresponds to Sword 
	SwordPosition = get_child(1).WeaponPositionHigh #gets the 2nd child in the node tree, and its variable "WeaponPositionHigh" - corresponds to Sword 


### Signals from the From Timer
func _on_timer_round_commit():
	InputLock = true
	emit_signal("RoundFinishIsAtPosition", ShieldPosition, SwordPosition)
	

func _on_timer_new_round():
	InputLock = false 

func _pauseGameInput(Pause) -> void:
	match Pause:
		"Pause":
			InputLock = true
		"Not Paused":
			InputLock = false


var PauseTicker:int = 0
var NotPaused:bool = true




func _unhandled_input(event):
	if event is InputEventKey and event.pressed: 
		match event.keycode: #Find the correct key input
			### Sword Movement
			KEY_ESCAPE:
				PauseTicker += 1
				if (PauseTicker % 2) != 0:
					NotPaused = false
					_pauseGameInput("Pause")
					
				else:
					NotPaused = true
					_pauseGameInput("Not Paused")
				

	if event is InputEventKey and event.pressed and InputLock != true: 
		# Is this a keyboard event that is happening,
		# AND the key is getting presse, not released?
		# AND we're not locked from doing inputs, because an attack is occuring?
		
		match event.keycode: #Find the correct key input
			### Sword Movement
			KEY_K: 
				%SwordChangePosAudio.play()
				SwordPosition += 1
				if SwordPosition > 1: #If K is pressed, check if the positional ID value is within the constraints
					SwordPosition = -1 #Then add 1
				#print(SwordPosition) #Printing, for debugging reasons
				
			KEY_J:
				%SwordChangePosAudio.play()
				SwordPosition -= 1
				if SwordPosition < -1: #If J is pressed, check if the positional ID value is within the constraints
					SwordPosition = 1
				#print(SwordPosition) #Printing, for debugging reasons
			### Shield Movement
			KEY_F:
				%ShieldChangePosAudio.play()
				ShieldPosition += 1
				if ShieldPosition > 1:  #If F is pressed, check if the positional ID value is within the constraints
					ShieldPosition = -1
				#print(ShieldPosition) #Printing, for debugging reasons
				
			KEY_D:
				%ShieldChangePosAudio.play()
				ShieldPosition -= 1
				if ShieldPosition < -1: #If D is pressed, check if the positional ID value is within the constraints
					ShieldPosition = 1
				#print(ShieldPosition) #Printing, for debugging reasons
			
			### Exceptions and Errors
			_:
				pass # If something unexpected is pressed, i.e B, or SpaceBar, do nothing!
				
		emit_signal("PositionShift", ShieldPosition, SwordPosition) #Emit the new SwordPosition/ShieldPosition to the various items to change their position










func _SelfBlinker():
	var Invisible:Color = Color(1,1,1,0) # Visible
	var Visible:Color
	var BlinkSpeed:float = 0.07 
	
	Visible = self.get_self_modulate()
	await get_tree().create_timer(0.3).timeout
	
	for i in 5:
		self.set_self_modulate(Invisible)
		await get_tree().create_timer(BlinkSpeed).timeout
		self.set_self_modulate(Visible)
		await get_tree().create_timer(BlinkSpeed).timeout
	
	set_self_modulate(Visible)

func _ShieldBlinker():
	var Invisible:Color = Color(1,1,1,0) # Visible
	var Visible:Color
	var BlinkSpeed:float = 0.07 
	
	$PlayerShield.set_position(Vector2($PlayerShield.position.x+450, $PlayerShield.position.y))
	
	Visible = $PlayerShield.get_self_modulate()
	await get_tree().create_timer(0.3).timeout
	
	for i in 5:
		$PlayerShield.set_self_modulate(Invisible)
		await get_tree().create_timer(BlinkSpeed).timeout
		$PlayerShield.set_self_modulate(Visible)
		await get_tree().create_timer(BlinkSpeed).timeout
	
	$PlayerShield.set_position(Vector2($PlayerShield.position.x-450, $PlayerShield.position.y))


func OpponentSwordMoverHit(): 
	%OpponentSword.set_position(Vector2(-1150, %OpponentSword.position.y))
	await get_tree().create_timer(0.7).timeout
	%OpponentSword.set_position(Vector2(-440, %OpponentSword.position.y))
	
func OpponentSwordMoverShield(): 
	%OpponentSword.set_position(Vector2(-990, %OpponentSword.position.y))
	await get_tree().create_timer(0.7).timeout
	%OpponentSword.set_position(Vector2(-440, %OpponentSword.position.y))

func _on_game_score_sender(Score):
	if Score.y == 1:
		OpponentSwordMoverHit()
		_SelfBlinker()
		%SwordHitsKnight.play()

	else:
		OpponentSwordMoverShield()
		_ShieldBlinker()
		%SwordHitsShield.play()


func _on_base_higher_order_pause():
	PauseTicker += 1
	if (PauseTicker % 2) != 0:
		NotPaused = false
		_pauseGameInput("Pause") # Replace with function body.
