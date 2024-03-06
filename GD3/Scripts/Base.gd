extends Node2D

## Screen scrolls
var Birdmoves:bool = false
@export var moveclock:float = 0

signal EndLevel()

var Tomas:float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.set_use_hdr_2d(true)
	SoundMod()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if $Bird.is_on_floor() or $Bird.is_on_wall():
		Birdmoves = false
		moveclock = 0
		
	if Birdmoves and !$Bird.is_on_wall_only() and $Background.position.x >= -35200:
		
		$Background.position.x -= moveclock * delta
		$Collision.position.x -= moveclock * delta
		$Foreground.position.x -= moveclock * delta
		$CageRope.position.x -= moveclock * delta
		%Text.position.x -= moveclock * delta
		
		moveclock = moveClockticker(moveclock)
		
	if $Background.position.x <= -35200:
		
		if $Background.position.x >= -35300:
			$Background.position.x -= moveclock * delta
			$Collision.position.x -= moveclock * delta
			$Foreground.position.x -= moveclock * delta
			$CageRope.position.x -= moveclock * delta
			$Bird.position.x -= moveclock * delta
		
		emit_signal("EndLevel")
		
		if Tomas <= 1:
			Tomas += 1
			%FinLabel.modulate = Color(1, 1, 1, Tomas)

func _on_cage_destroy():
	Birdmoves = true

func moveClockticker(ClockMove) -> float:
	var ScrollSpeedSetter:float
	
	if ClockMove <= 180:
		ScrollSpeedSetter = lerpf(ClockMove, 200, 0.03)
		
	if ClockMove >= 180 and ClockMove <= 480:
		ScrollSpeedSetter = lerpf(ClockMove, 500, 0.01)
		
	if ClockMove >= 480 and ClockMove <= 650:
		ScrollSpeedSetter = lerpf(ClockMove, 650, 0.01)
	
	return ScrollSpeedSetter


func _on_apartment_ambiance_finished():

	%ApartmentAmbiance.play()
	

func _on_city_ambiance_finished():
	%CityAmbiance.play() 


func _on_park_ambiance_finished():
	%ParkAmbiance.play()


func _on_bird_ambiance_finished():
	%BirdAmbiance.play()

func SoundMod():
	
	if $Background.position.x <= -12500:
		%ApartmentAmbiance.set_volume_db(lerpf(%ApartmentAmbiance.get_volume_db(), -80, 0.04))
	
	if $Background.position.x <= -12500 and $Background.position.x >= -23500:
		%CityAmbiance.set_volume_db(lerpf(%CityAmbiance.get_volume_db(), -12, 0.05))
		%BirdAmbiance.set_volume_db(lerpf(%CityAmbiance.get_volume_db(), -12, 0.05))
		%ApartmentAmbiance.set_pitch_scale(lerpf(%ApartmentAmbiance.get_pitch_scale(), 0.40, 0.03))
	
	
	if $Background.position.x <= -23500:
		%CityAmbiance.set_volume_db(lerpf(%CityAmbiance.get_volume_db(), -50, 0.05))
		%CityAmbiance.set_pitch_scale(lerpf(%CityAmbiance.get_pitch_scale(), 0.40, 0.03))
		%BirdAmbiance.set_volume_db(lerpf(%CityAmbiance.get_volume_db(), -20, 0.05))
		%ParkAmbiance.set_volume_db(lerpf(%ParkAmbiance.get_volume_db(), -12, 0.05))
	
	await get_tree().create_timer(0.2).timeout
	SoundMod()
