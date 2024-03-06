extends CharacterBody2D

var run_speed = 350
var jump_speed = -1 * 1200
var gravity = 2500

@export var CurrentLevelActive:String = "normal"

## LevelChangerSigs
signal LevelChanger(LevelWeGoingTo)
signal WhatLevelToQueueFree(LevelToRelieve)

## Scripted Level Changers
signal SpikesLevelChanger()

## Sounds
signal JumpSound()
signal WierdJumpSound()
signal RunningSound()
signal WierdRunningSound()
signal StopRunning()

## Wierd Platform Connect
signal ConnectWithFirstWierdPlatform()

## Player State Sigs
signal PlayerPositioninX(PlayerPositioninX)

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('Forward')
	var left = Input.is_action_pressed('Back')
	var jump = Input.is_action_just_pressed('Jump')
	
	## Level Switch Debug
	var WierdLevel = Input.is_action_just_pressed('WierdDebug')
	var SpikeLevel = Input.is_action_just_pressed('SpikeDebug')
	var NormalLevel = Input.is_action_just_pressed('NormalDebug')
	
	## Controls
	if is_on_floor() and jump:
		velocity.y = jump_speed
		if CurrentLevelActive != "wierd":
			emit_signal("JumpSound")
		else:
			emit_signal("WierdJumpSound")
	if right and !is_on_wall():
		velocity.x += run_speed
		if CurrentLevelActive != "wierd":
			emit_signal("RunningSound")
		else:
			emit_signal("WierdRunningSound")
		
	if left and !is_on_wall():
		velocity.x -= run_speed
		if CurrentLevelActive != "wierd":
			emit_signal("RunningSound")
		else:
			emit_signal("WierdRunningSound")
			
	if !left and !right:
		emit_signal("StopRunning")
	
	## Exits Game
	var quit = Input.is_action_just_pressed('Quit')
	if quit:
		get_tree().quit(0)
	
	## Debug Level Switches
	var LevelWeGoingTo:String
	var LevelToRelieve:String
	
	if NormalLevel and CurrentLevelActive != "normal":
		"Goto Normal Level"
		LevelWeGoingTo = "normal"
		velocity.y = jump_speed
		
		match CurrentLevelActive:
			"normal":
				LevelToRelieve = "normal"
				emit_signal("WhatLevelToQueueFree", LevelToRelieve)
			"wierd":
				LevelToRelieve = "wierd"
				emit_signal("WhatLevelToQueueFree", LevelToRelieve)
			"spikes":
				LevelToRelieve = "spikes"
				emit_signal("WhatLevelToQueueFree", LevelToRelieve)
		
		CurrentLevelActive = "normal"
		emit_signal("LevelChanger", LevelWeGoingTo)
		
	if WierdLevel and CurrentLevelActive != "wierd":
		"Goto Wierd Level"
		LevelWeGoingTo = "wierd"
		velocity.y = jump_speed
		
		match CurrentLevelActive:
			"normal":
				LevelToRelieve = "normal"
				emit_signal("WhatLevelToQueueFree", LevelToRelieve)
			"wierd":
				LevelToRelieve = "wierd"
				emit_signal("WhatLevelToQueueFree", LevelToRelieve)
			"spikes":
				LevelToRelieve = "spikes"
				emit_signal("WhatLevelToQueueFree", LevelToRelieve)
		
		CurrentLevelActive = "wierd"
		emit_signal("LevelChanger", LevelWeGoingTo)
		
	if SpikeLevel and CurrentLevelActive != "spikes":
		"Goto Spike Level"
		LevelWeGoingTo = "spikes"
		velocity.y = jump_speed
		
		match CurrentLevelActive:
			"normal":
				LevelToRelieve = "normal"
				emit_signal("WhatLevelToQueueFree", LevelToRelieve)
			"wierd":
				LevelToRelieve = "wierd"
				emit_signal("WhatLevelToQueueFree", LevelToRelieve)
			"spikes":
				LevelToRelieve = "spikes"
				emit_signal("WhatLevelToQueueFree", LevelToRelieve)
		
		CurrentLevelActive = "spikes"
		emit_signal("LevelChanger", LevelWeGoingTo)

func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	move_and_slide()

func _ifspikes():
	if CurrentLevelActive == "spikes" and self.position.y >= 490:
		gravity = -2500
		emit_signal("SpikesLevelChanger")
		set_up_direction(Vector2.DOWN)
		jump_speed = 1200
		%Character.rotate(deg_to_rad(180))
		await get_tree().create_timer(0.7).timeout
		emit_signal("ConnectWithFirstWierdPlatform")
		CurrentLevelActive = "wierd"
		
	else:
		await get_tree().create_timer(0.2).timeout
		_ifspikes()


func _ready():
	set_up_direction(Vector2.UP)
	_get_scree_scroll_position()
	_ifspikes()

func _get_scree_scroll_position():
	var PlayerPositioninX 
	PlayerPositioninX = floorf(self.position.x + 82.4)
	await get_tree().create_timer(0.01).timeout
	emit_signal("PlayerPositioninX", PlayerPositioninX)
	if PlayerPositioninX >= 2740:
		CurrentLevelActive = "spikes"
	_get_scree_scroll_position()



