extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayAnimation()


func PlayAnimation():
	if !self.is_playing():
		await get_tree().create_timer(0.25).timeout
		self.play("default")
	else:
		pass
	
	await get_tree().create_timer(1).timeout
	PlayAnimation()
