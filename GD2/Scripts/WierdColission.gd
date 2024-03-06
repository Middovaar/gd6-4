extends Node2D

var CanAutoScroll:bool = false
var Fader:float


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if CanAutoScroll and self.position.y >= -2400:
		if !$OtherPlatforms.visible:
			$OtherPlatforms.set_visible(true)
			$OtherPlatforms.set_collision_mask_value(1, true)
			$OtherPlatforms.set_collision_mask_value(4, false)
			$OtherPlatforms.set_collision_layer_value(1, true)
			$OtherPlatforms.set_collision_layer_value(4, false)
		if $OtherPlatforms.visible:
			$OtherPlatforms.set_modulate(Color(1, 1, 1, Fader))
			Fader += 0.1
		self.position.y -= 40 * delta
	else:
		AutoScrollEnd()


func _on_ready_for_movement():
	CanAutoScroll = true

func AutoScrollEnd():
	pass
