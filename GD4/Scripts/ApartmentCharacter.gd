extends CharacterBody2D


const SPEED = 400.0

## Teleporter Values ##
const TeleporterSpawner:Array = [-1777, 430] #Where the player teleports to on the screen after having gone to another room
var CurrentScreenPosition:int = 0 #What Screen Are we on. 0 for bedroom, 1 for Hallway, 2 for kitchen/workstation

## Interactable Caster, x = if you can interact, y is which ID
var IsOverInteractableAndInteractableID:Vector2i = Vector2i.ZERO #
signal InteractablesInfo(IsOverInteractableAndInteractableID)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$Guy.set_animation("Default")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Back", "Forward")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("Back") or velocity.x < 0:
		$Guy.play("WalkingRight") 
	
	if Input.is_action_just_pressed("Forward") or velocity.x > 0:
		$Guy.play("WalkingLeft")
	
	if Input.is_action_just_released("Back") or Input.is_action_just_released("Forward"):
		$Guy.play("Default")
	
	## Interactables
	if Input.is_action_just_pressed("Jump") and IsOverInteractableAndInteractableID.x != 0:
		emit_signal("InteractablesInfo", IsOverInteractableAndInteractableID)

func _on_teleporters_entered(body_rid, body, body_shape_index, local_shape_index):
	
	if body is CharacterBody2D and local_shape_index == 0 and CurrentScreenPosition != 2:
		CurrentScreenPosition += 1
		position.x = TeleporterSpawner[1]

	if body is CharacterBody2D and local_shape_index == 1 and CurrentScreenPosition != 0:
		CurrentScreenPosition -= 1
		position.x = TeleporterSpawner[0]


func _on_apartment_interactables_interactor(body_rid, body, body_shape_index, local_shape_index):
	if body is CharacterBody2D:
		$Interactable.modulate = Color.WHITE
		IsOverInteractableAndInteractableID = Vector2i(1, local_shape_index)

func _on_apartment_interactables_exited(body_rid, body, body_shape_index, local_shape_index):
	$Interactable.modulate = Color.TRANSPARENT
	IsOverInteractableAndInteractableID = Vector2i.ZERO
