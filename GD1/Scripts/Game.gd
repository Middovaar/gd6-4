extends Node2D

@export_range(-255, 255, 1) var Score:float

### Game Rules ###
@export_group("Game Rules")
@export_range(0.5, 10, 0.1,) var RoundTimeLimit:float = 5 #
const TimerTickSpeed = 0.1
@export_range(0.1, 1, 0.01) var AIChoiceSpeed:float = 0.3 

signal TimerConfiguration(RoundTimeLimit, TimerTickSpeed)
signal ShowSparring(WeaponMovements)




# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("TimerConfiguration", RoundTimeLimit, TimerTickSpeed)
	PlayGameMusic()
	pass # Replace with function body.

func PlayGameMusic():
	if !%GameMusic.is_playing():
		%GameMusic.play()
	else:
		pass
	await get_tree().create_timer(0.3).timeout
	PlayGameMusic()
	
"""
Implement a win condition where if the difference is >8, stop the game, and show win/loose screen tnx :)

"""


signal ScoreSender(Score)

var ShieldPositionKnight
var SwordPositionKnight
var ShieldPositionOpponent
var SwordPositionOpponent

var CatchingPlayerValues:int
const Referree = 0


func _ScoreSender():
	var ScoreSender:Vector2i
	
	if CatchingPlayerValues % 2 == Referree:
		ScoreSender = _DoScoreCalc(ShieldPositionKnight, SwordPositionKnight, ShieldPositionOpponent, SwordPositionOpponent)
		emit_signal("ScoreSender", ScoreSender)


func _on_knight_player_round_finish_is_at_position(ShieldPosition, SwordPosition):
	ShieldPositionKnight = ShieldPosition
	SwordPositionKnight = SwordPosition
	CatchingPlayerValues += 1
	_ScoreSender()


func _on_opponent_player_round_finish_is_at_position(ShieldPosition, SwordPosition):
	ShieldPositionOpponent = ShieldPosition
	SwordPositionOpponent = SwordPosition
	CatchingPlayerValues += 1
	_ScoreSender()



func _DoScoreCalc(ShieldPositionKnight, SwordPositionKnight, ShieldPositionOpponent, SwordPositionOpponent) -> Vector2i:
	
	var Score:Vector2i # x for player, y for opponent
	
	### Calculate Knight's Score ###
	if SwordPositionKnight == ShieldPositionOpponent:
		Score.x = 0
	else:
		if SwordPositionKnight == SwordPositionOpponent:
			Score.x = 1
		else:
			Score.x = 1
	
	### Calculate Opponent's Score ###
	if SwordPositionOpponent == ShieldPositionKnight:
		Score.y = 0
	else:
		if SwordPositionOpponent == SwordPositionKnight:
			Score.y = 1
		else:
			Score.y = 1
	
	return Score
	
	
	
