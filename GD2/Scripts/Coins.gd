extends CollisionShape2D

signal CollectionSound()



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_18_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false


func _on_area_2d_17_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false

func _on_area_2d_15_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false

func _on_area_2d_14_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_13_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_12_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_11_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_10_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_9_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.

func _on_area_2d_8_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.

func _on_area_2d_7_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_6_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_4_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_2_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_3_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_5_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.


func _on_area_2d_16_body_entered(body):
	if self.visible == true:
		emit_signal("CollectionSound")
	self.visible = false # Replace with function body.
