extends Node2D

var Scrolling:float
@export_range(0, 5, 0.1) var ScrollingWeight:float



# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().PushXPlayerPos.connect(_on_Casted_Player_X)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Casted_Player_X(PlayerPositioninX):
	var CurrentX:float
	var RectifiedX:float
	
	CurrentX = self.position.x
	RectifiedX = -(PlayerPositioninX * ScrollingWeight)
	self.position.x = RectifiedX
