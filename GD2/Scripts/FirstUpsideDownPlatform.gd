extends CollisionShape2D

var sindisplacement:float
@onready var Player = get_node("/root/Base/Player")

signal ReadyForMovement()
signal LandingSound()

# Called when the node enters the scene tree for the first time.
func _ready():
	Player.ConnectWithFirstWierdPlatform.connect(_on_Player_landed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Player_landed():
	var playlandingsound:int = 1
	if Player.velocity.y < 0.5:
		const counter = PI
		if sindisplacement < counter:
			if playlandingsound == 1:
				emit_signal("LandingSound")
			sindisplacement = 0.02 + sindisplacement
			self.position.y = 210 + 30 * -sin(sindisplacement)
			await get_tree().create_timer(0.01).timeout
			playlandingsound += 1
			_on_Player_landed()
		else:
			await get_tree().create_timer(1.0).timeout
			emit_signal("ReadyForMovement")
		
	else:
		await get_tree().create_timer(0.1).timeout
		_on_Player_landed()
