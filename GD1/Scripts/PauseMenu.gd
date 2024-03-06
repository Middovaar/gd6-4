extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_visible(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_timer_is_paused():
	self.set_visible(true)
	%MenuOpenDismiss.play()


func _on_timer_is_not_paused():
	self.set_visible(false) 
	%MenuOpenDismiss.play()
