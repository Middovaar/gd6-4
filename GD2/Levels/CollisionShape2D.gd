extends CollisionShape2D

@export var IsCollected:bool
@onready var Player = get_node("/root/Base/Player")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if !IsCollected:
		self.visible = false
	
	
