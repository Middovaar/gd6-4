extends Node2D

signal YeahWereDoneWithTheAnimation()
var OhShitIsThisActive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	if OhShitIsThisActive:
		$A.position.x += 2 
		$A.position.y += delta * ProjectSettings.get_setting("physics/2d/default_gravity") 
		
		$B.position.x -= 4
		$B.position.y += delta * ProjectSettings.get_setting("physics/2d/default_gravity")
		
		$C.position.x += 5
		$C.position.y += delta * ProjectSettings.get_setting("physics/2d/default_gravity")
	
	

func _on_character_body_2d_cage_destroyer_animation():
	OhShitIsThisActive = true
	await get_tree().create_timer(5).timeout
	emit_signal("YeahWereDoneWithTheAnimation")
	queue_free()
