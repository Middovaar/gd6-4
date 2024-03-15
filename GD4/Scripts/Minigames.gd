extends Node2D

const SizeFitter:Vector2 = Vector2(0.87, 0.81)
const PositionFitter:Vector2 = Vector2(123, 76)

var NumberOfGamesCleared:int = 0
var TypeOfMinigame
var WaitingToDismissClearMsg:bool = false

signal Minigame(TypeOfMinigame)
signal OnScore()
signal CutMinigameSound()

@onready var Typing = preload("res://GD4/Levels/TypeYouAss.res").instantiate()
var Colouring

### Games
@onready var Jousting = preload("res://GD1/SceneManager.tscn").instantiate()


func _ready():
	TypeOfMinigame = randi() % 1
	_spawn_minigame(TypeOfMinigame)
	emit_signal("Minigame", TypeOfMinigame)

func _spawn_minigame(TypeOfMinigame):
	match TypeOfMinigame:
		0:
			
			add_child(Typing)
			$TypeYouAss.z_index = 1
			$TypeYouAss.position = PositionFitter
			$TypeYouAss.scale = SizeFitter
			$TypeYouAss.Score.connect(TyperScorer)
			
		_:
			pass

func TyperScorer():
	emit_signal("OnScore")

func _on_typer_new_game_req():
	NumberOfGamesCleared += 1
	$TypeYouAss.queue_free()
	await get_tree().create_timer(0.01).timeout
	$Score.text = """[center][font_size=320]""" + str(0) + """[/font_size] 
Codeblocks Finished!"""
	if NumberOfGamesCleared == 3:
		CallInGameGD()
	else:
		_ready()

func CallInGameGD():
	$Clear.visible = true
	WaitingToDismissClearMsg = true

func CallInGDOne():
	print("hi?")
	emit_signal("CutMinigameSound")
	add_child(Jousting)
	$SceneManager.z_index = 3
	$SceneManager.scale = Vector2(0.655, 0.635)
	$SceneManager.position = Vector2(341, 157)


func _input(event):
	if Input.is_action_just_pressed("Jump") and WaitingToDismissClearMsg:
		$Clear.visible = false
		CallInGDOne()
		WaitingToDismissClearMsg = false
	
