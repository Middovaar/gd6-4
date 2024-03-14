extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready():
	energy = 0.72
	lightcycle() 

func lightcycle():
	await get_tree().create_timer(0.4).timeout
	for n in 3:
		energy = 1.44
		await get_tree().create_timer(0.05).timeout
		energy = 0.72
		n += 1
	await get_tree().create_timer(0.05).timeout
	energy = 0.72
	for n in 2:
		energy = 1.44
		await get_tree().create_timer(0.05).timeout
		energy = 0.72
		n += 1
	
	await get_tree().create_timer(0.05).timeout
	energy = 0.72
	lightcycle()
