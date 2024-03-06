extends Sprite2D


signal PositionShift(ShieldPosition, SwordPosition)

signal RoundFinishIsAtPosition(ShieldPosition, SwordPosition)

### Screen Position, in case that is needed ###
var ScreenPosition

#### Weapon Position IDs ####
var ShieldPosition:int
var SwordPosition:int # The index of where we are, position-wise

@export var InputLock:bool # Input Lock, because an action is happening already

var AttackChoicePrevented:bool = false


func _ready():
	ScreenPosition = get_global_position() #gets the self object position on canvas
	
	ShieldPosition = $OpponentShield.WeaponPositionHigh #gets the 1st child in the node tree, and its variable "WeaponPositionHigh"  - corresponds to Shield 
	SwordPosition = $OpponentSword.WeaponPositionHigh #gets the 2nd child in the node tree, and its variable "WeaponPositionHigh"  - corresponds to Sword 
	
	AITick() # Run the AI

func _on_timer_round_commit():
	AttackChoicePrevented = true
	emit_signal("RoundFinishIsAtPosition", ShieldPosition, SwordPosition)
	

func _on_timer_new_round():
	AttackChoicePrevented = false

### The AI Magic happens here ###

func AITick() -> void:
	
	if NotPaused and !AttackChoicePrevented:
		emit_signal("PositionShift", ShieldPosition, SwordPosition) #Send the generated Positions to the weapons, telling them to update
	
	await get_tree().create_timer(0.3).timeout # Wait 0.3 seconds
	
	### Is the AI in a state in which changing Weapon positions is cringe and bad?
	if AttackChoicePrevented:
		AITick() #Go back to the top
		
	else: # Or nah?
		ShieldPosition = (_Ai_ChoosePosition().x) # Update the weapon positions to the new randomly generated positions
		SwordPosition = (_Ai_ChoosePosition().y)
		AITick() #Go back to the top

func _Ai_ChoosePosition() -> Vector2i: 
	
	"""
	Basically what happens here is that we randomly generate a 32-bit integer in randi()
	We then do:
	
	(randi() % 2) -> 0, 1, 2
	
	Subtract 1 to get -1, 0, 1
	
	Put the newly minted -1, 0, or 1 into the ProcessValue Variable
	To prevent long chains of the AI picking the same position over and over, check to see if the newly minted value is the same as the previous value
	
	if not:
	push ProcessValue -> ReturnEvaluation and post it to the weapons 
	
	if yes:
	Add another random value, Do the same calculation again and push ProcessValue -> ReturnEvaluation
	"""
	
	var ProcessValue:Vector2i 
	var ReturnEvaluation:Vector2i
	
	ProcessValue.x = (randi() % 2)
	ProcessValue.y = (randi() % 2)
	
	if ProcessValue.x == ShieldPosition:
		ReturnEvaluation.x = ((ProcessValue.y + (randi() % 2)+ 1) % 2)-1
	else:
		ReturnEvaluation.x = ProcessValue.x
		
	if ProcessValue.y == SwordPosition:
		ReturnEvaluation.y = ((ProcessValue.y + (randi() % 2)+ 1) % 2)-1
	else:
		ReturnEvaluation.y = ProcessValue.y

	return ReturnEvaluation
	
func _SuccessfulHit() -> void:
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
				else:
					NotPaused = true



func _OpponentSelfBlinker():
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


func _OpponentShieldBlinker():
	var Invisible:Color = Color(1,1,1,0) # Visible
	var Visible:Color
	var BlinkSpeed:float = 0.07 
	
	$OpponentShield.set_position(Vector2(-300, $OpponentShield.position.y))
	NotPaused = false
	
	Visible = $OpponentShield.get_self_modulate()
	await get_tree().create_timer(0.3).timeout
	
	for i in 5:
		$OpponentShield.set_self_modulate(Invisible)
		await get_tree().create_timer(BlinkSpeed).timeout
		$OpponentShield.set_self_modulate(Visible)
		await get_tree().create_timer(BlinkSpeed).timeout
		
	$OpponentShield.set_position(Vector2(150, $OpponentShield.position.y))
	NotPaused = true

func PlayerSwordMoverHit(): 
	%PlayerSword.set_position(Vector2(1440, %PlayerSword.position.y))
	await get_tree().create_timer(0.7).timeout
	%PlayerSword.set_position(Vector2(440, %PlayerSword.position.y))
	
func PlayerSwordMoverShield(): 
	%PlayerSword.set_position(Vector2(990, %PlayerSword.position.y))
	await get_tree().create_timer(0.7).timeout
	%PlayerSword.set_position(Vector2(440, %PlayerSword.position.y))

func _on_game_score_sender(Score):
	if Score.x == 1:
		PlayerSwordMoverHit()
		_OpponentSelfBlinker()
		%SwordHitsKnight.play()
		
	else:
		PlayerSwordMoverShield()
		emit_signal("PLayerDoNotScore")
		_OpponentShieldBlinker()
		%SwordHitsShield.play()


func _on_base_higher_order_pause():
	PauseTicker += 1
	if (PauseTicker % 2) != 0:
		NotPaused = false
	else:
		NotPaused = true # Replace with function body.
