extends CharacterBody2D



################## NOTES #####################
## "Original Formula for gravity. 
# velocity.y += gravity * delta"
## Detects if the player has hit the floor
# is_on_floor()
## Timer
# get_tree().create_timer( time ).timeout
## Awaa

## Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

################## Player Ini Domain Vars ######################

## Horizontal Speed
const SPEED = 300.0
## Jump Velocity
const JumpFlapVelocity = -400.0

## Flap Detector, and the Vector Size of Mouse Movement
var MouseIsFlappingByMovingDownRn:bool
var MouseVector:Vector2i

## Are we in the cage?
var Captured:bool = true

## How Many times have we tried to escape from the cage?
var HowManyTimesWeveTriedEscapingFromTheCage:float = 0

## Is the animation for the Cage Destroyer done?
signal CageDestroyerAnimation
var CageDestroyerAnimationIsFinished:bool = false

#################################################################
################ Player Gameplay Domain Vars ####################

## If on the floor, how many times have we jumped? Gets Reset if in the air for more than 1 second
var JumpNumber:int = 0

## AftJump indicates wever or not the player is considered airborn
var AftJump:bool = false

#################################################################
################ Player Animations ####################

var FrameRequester:Vector4i = Vector4i(0, 0, 0, 0)
var AtEndLevel:bool = false
var WaitFlapper:bool = false

func _ready():
	Capturer()

func _physics_process(delta):
	#### Mouse Processings
	## Returns downward mousemovement. Clamps the Y-axis to return -> 0+ eval. X-axis unclamped - probably will remain unhandled
	MouseVector = Vector2i(floor(Input.get_last_mouse_velocity().x), clamp(floor(Input.get_last_mouse_velocity().y / 100)-10, 0, INF))
	# Checks if Mouse is going down
	if MouseVector.y > 0:
		MouseIsFlappingByMovingDownRn = true
	else:
		MouseIsFlappingByMovingDownRn = false
	
	
	#### Falling, Flapping, and Gliding
	## Adds gravity, allows objects to fall.
	if not is_on_floor() and not Captured:
		## When Flapping Flapping
		if !MouseIsFlappingByMovingDownRn:
			if velocity.y <= JumpFlapVelocity:
				## Clamps the velocity of flapping gets too wacky if mouse speed is greater than the Jump Velocity
				velocity.y = -250
				
				
			else:
				## Fall Like Normal
				velocity.y += gravity * delta
		else:
			## This actually makes the flap happen
			velocity.y += (JumpFlapVelocity * MouseVector.y)/2 * delta
			PlayFlappSound()
				
	
	### Getting Out, Shakes the player to simulate trying to get out.
	if Captured and MouseIsFlappingByMovingDownRn:
		const ShakeTimestep = 0.03
		
		var HowM = func(x): return HowManyTimesWeveTriedEscapingFromTheCage / 4
		
		%WingSound.play()
		
		# PlayerAnimation Shaker in here!
		for n in 3:
			$Player.position = Vector2(15 + (HowManyTimesWeveTriedEscapingFromTheCage + 0.25 * 4 ), -25 + (HowManyTimesWeveTriedEscapingFromTheCage + 0.25 / 4))
			await get_tree().create_timer(ShakeTimestep).timeout
			$Player.position = Vector2(5 - (HowManyTimesWeveTriedEscapingFromTheCage + 0.25 * 4), -15 - (HowManyTimesWeveTriedEscapingFromTheCage + 0.25 / 4))
			await get_tree().create_timer(ShakeTimestep).timeout
			$Player.position = Vector2(5 + (HowManyTimesWeveTriedEscapingFromTheCage + 0.25 * 4), -25 + (HowManyTimesWeveTriedEscapingFromTheCage + 0.25 / 4))
			await get_tree().create_timer(ShakeTimestep).timeout
			$Player.position = Vector2(15 - (HowManyTimesWeveTriedEscapingFromTheCage + 0.25 * 4), -15 - (HowManyTimesWeveTriedEscapingFromTheCage + 0.25 / 4))
			await get_tree().create_timer(ShakeTimestep).timeout
			$Player.position = Vector2(10, -20)
		
		HowManyTimesWeveTriedEscapingFromTheCage += 0.1
		
		if HowManyTimesWeveTriedEscapingFromTheCage >= 5:
			Captured = false
	
	### Initial Animation for the Player getting out of the cage!
	if !Captured:
		$Player.set_rotation(lerpf($Player.rotation, 0, 0.3))
		CageDestroyer()
	
	
	#### 
	## Validates the type of jump done by the player, and picks between 4 heights; a small, a little bigger, and a big one.
	if MouseIsFlappingByMovingDownRn and is_on_floor() and !AtEndLevel:
		
		CheckIfStillOnGround()
		
		match JumpNumber:
			0:
				velocity.y = JumpFlapVelocity * 0.5 * 0.1 
				JumpNumber = 1
			1:
				velocity.y = JumpFlapVelocity * 1* 0.1 
				JumpNumber = 2
			2:
				velocity.y = JumpFlapVelocity * 2* 0.1 
				JumpNumber = 3
			3:
				velocity.y = JumpFlapVelocity * 4* 0.1 
				JumpNumber = 0
	
	move_and_slide()

func Capturer():
	if HowManyTimesWeveTriedEscapingFromTheCage > 0:
		HowManyTimesWeveTriedEscapingFromTheCage -= 1
	await get_tree().create_timer(1).timeout
	Capturer()

func CageDestroyer():
	if !CageDestroyerAnimationIsFinished:
		if %BrokenCage != null:
			%BrokenCage.visible = true
	%CageRope.visible = true
	emit_signal("CageDestroyerAnimation")
	Animator()
	$Cage.visible = false

func CheckIfStillOnGround():
	await get_tree().create_timer(1.0).timeout
	if not is_on_floor():
		AftJump = false

func Animator():
	if not is_on_floor() and not is_on_wall() and get_parent().moveclock > 250 and !AtEndLevel:
		if %PlayerSprite.get_animation() != "fly":
			%PlayerSprite.play("fly")
		else:
			pass 

	if not is_on_floor() and not is_on_wall() and get_parent().moveclock <= 250:
		if %PlayerSprite.get_animation() != "land":
			%PlayerSprite.play("land") 
		else:
			pass

	if not is_on_floor() and is_on_wall():
		if %PlayerSprite.get_animation() != "land":
			%PlayerSprite.play("land") 
		else:
			pass
		
	if is_on_floor():
		if %PlayerSprite.get_animation() != "default":
			%PlayerSprite.play("default") 
		else:
			pass
	
	if AtEndLevel and not is_on_floor():
		if %PlayerSprite.get_animation() != "land":
			%PlayerSprite.play("land") 
		else:
			pass

	await get_tree().create_timer(0.3).timeout
	Animator()


func _on_broken_cage_yeah_were_done_with_the_animation():
	CageDestroyerAnimationIsFinished = true


func _on_base_end_level():
	AtEndLevel = true # Replace with function body.

func PlayFlappSound():
	if !WaitFlapper:
		%WingSound.play()
		WaitFlapper = true
	await get_tree().create_timer(0.2).timeout
	
	if !MouseIsFlappingByMovingDownRn:
		WaitFlapper = false
