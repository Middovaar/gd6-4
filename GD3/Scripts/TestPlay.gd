extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0

## Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

## Awaa
var GlideEngager:float = 1
var AftJump:bool

## Flap Detector
var MouseMovementChecker:bool
var MouseVector:Vector2i

## Ground Jump Detector
var JumpNumber:int = 0

func _ready():
	set_safe_margin(0.01)
	ResetJumpNumber()


func _physics_process(delta):
	
	## Returns downward mousemovement. Clamps the Y-axis to return -> 0+ eval. X-axis unclamped - probably will remain unhandled
	MouseVector = Vector2i(floor(Input.get_last_mouse_velocity().x), clamp(floor(Input.get_last_mouse_velocity().y / 100)-10, 0, INF))
	if MouseVector.y > 0:
		MouseMovementChecker = true
	else:
		MouseMovementChecker = false
	# Debug Y-axis mouse movement
	
	## Add the gravity.
	if not is_on_floor():
		if !MouseMovementChecker:
			if velocity.y <= -300:
				velocity.y = -250
				GlideEngager = 1
			else:
				GravityAndGlide(delta)
					
		else:
			velocity.y += (JUMP_VELOCITY * MouseVector.y)/2 * delta
	
	## Checks if on ground perching.
	
	if is_on_floor_only():
		AftJump = true
		GlideEngager = 1
	
	print(global_position.x, " ")
	
	## Validates the type of jump done by the player, and picks between 4 heights; a small, a little bigger, and a big one.
	if Input.is_action_just_pressed("jump") and is_on_floor_only():
		
		CheckIfStillOnGround()
		
		match JumpNumber:
			0:
				velocity.y = JUMP_VELOCITY * 0.5
				JumpNumber = 1
			1:
				velocity.y = JUMP_VELOCITY * 1
				JumpNumber = 2
			2:
				velocity.y = JUMP_VELOCITY * 2
				JumpNumber = 3
			3:
				velocity.y = JUMP_VELOCITY * 4
				JumpNumber = 0
		
	## Controlls sideways motion, refactor into a separate movement function later oki XOXOXO love you Tolz <3
	var direction = 1
	if !is_on_floor() and global_position.y < 900 and !AftJump:
		velocity.x = lerpf(velocity.x, direction * SPEED, 0.04)
	if !is_on_floor() and global_position.y > 900 and !AftJump:
		velocity.x = lerpf(velocity.x, 0, 0.05)
	if !is_on_floor() and global_position.y > 950 and !AftJump:
		velocity.x = lerpf(velocity.x, 0, 0.09)
	if !is_on_floor() and global_position.y > 1000 and !AftJump:
		velocity.x = 0
	if is_on_floor():
		velocity.x = 0
		
	if global_position.x >= 2000:
		global_position.x = -200
	
	move_and_slide()

func GravityAndGlide(delta):
	# Normal falling motion, before gliding happens
	velocity.y = velocity.y * GlideEngager + (gravity * delta) 
	
	# Speed GOOD! Glide mode ENGAGED!!!
	if velocity.y > 500:
		Glider(delta)
	
	# Slows down before landing
	# global_position.y preliminary based on screen size, should have a way to make it detect ground proximity
	if global_position.y > 900 and global_position.y < 950 and GlideEngager >= 0.01 and !AftJump:
		GlideEngager -= 0.7 * delta
		
	if global_position.y > 950 and GlideEngager <= 1 and !AftJump:
		GlideEngager += 1 * delta





## Handles the gradual increase of glide slow speed
func Glider(delta):
	if GlideEngager >= 0.9:
		GlideEngager -= 2 * delta
		await get_tree().create_timer(0.1).timeout
		Glider(delta)

## Unblocks the Aft JUmp release of superslow mode near ground
func CheckIfStillOnGround():
	await get_tree().create_timer(1.0).timeout
	if not is_on_floor():
		AftJump = false

## Resets the jump counter, making the small jump the first that happens should flight be engaged
func ResetJumpNumber() -> void:
	if not is_on_floor():
		await get_tree().create_timer(2.7).timeout
		JumpNumber = 0
	else:
		await get_tree().create_timer(0.5).timeout
		pass
	ResetJumpNumber()
