extends HBoxContainer

var ScoreCounter:Vector2i


## Enters here from the Game Logic Script with score calculation done ##
func _on_game_score_sender(Score):
	
	ScoreCounter = Countup(Score) # Append the finished Score calculation to the currently displayed score
	ScoreSoundPlayer(Score)
	
	
	## Display the score ##
	$PlayerScoreCont/PlayerScore.bbcode_text = "[bgcolor=#0000009f][center]" + str(ScoreCounter.x) + "[/center][/bgcolor]" 
	$OpponentScoreCont/OpponentScore.bbcode_text = "[bgcolor=#0000009f][center]" + str(ScoreCounter.y) + "[/center][/bgcolor]"
	

func Countup(Score) -> Vector2i:
	
	## Interpret the score ##
	# x = Player
	# y = Opponent
	
	if Score.x == 1: # +1 Score for Player
		
		# Extra Effects #
		_XBlinker() 
		
		# Add 1 to the Player score counter
		ScoreCounter.x += 1
	else:
		# +0 Score for the Player, do nothing
		pass
	
	if Score.y == 1: # +1 Score for Opponent
		# Extra Effects #
		_YBlinker()
		
		# Add 1 to the Opponent score counter
		ScoreCounter.y += 1
	else:
		pass 
	
	return ScoreCounter # Return the resulted interpretation


func ScoreSoundPlayer(Score) -> void:
	
	match Score:
		
		Vector2i(0, 1):
			%PointOpponent.play()
		
		Vector2i(1, 0):
			%PointPlayer.play()
			
		Vector2i(1, 1):
			%PointBoth.play()
		_:
			pass


func _XBlinker():
	var Invisible:Color = Color(1,1,1,0) # Visible
	var Visible:Color
	var BlinkSpeed:float = 0.07 
	
	Visible = $PlayerScoreCont/PlayerScore.get_self_modulate()
	await get_tree().create_timer(0.3).timeout
	
	for i in 5:
		$PlayerScoreCont/PlayerScore.set_self_modulate(Invisible)
		await get_tree().create_timer(BlinkSpeed).timeout
		$PlayerScoreCont/PlayerScore.set_self_modulate(Visible)
		await get_tree().create_timer(BlinkSpeed).timeout
	
	set_self_modulate(Visible)

func _YBlinker():
	var Invisible:Color = Color(1,1,1,0) # Visible
	var Visible:Color
	var BlinkSpeed:float = 0.07 
	
	Visible = $OpponentScoreCont/OpponentScore.get_self_modulate()
	await get_tree().create_timer(0.3).timeout
	
	for i in 5:
		$OpponentScoreCont/OpponentScore.set_self_modulate(Invisible)
		await get_tree().create_timer(BlinkSpeed).timeout
		$OpponentScoreCont/OpponentScore.set_self_modulate(Visible)
		await get_tree().create_timer(BlinkSpeed).timeout
	
	set_self_modulate(Visible)
