extends RichTextLabel

var Score:int
signal NewGameReq()


func _on_minigames(TypeOfMinigame):
	match TypeOfMinigame:
		0:
			pass
		1:
			pass


func _on_score():
	Score += 1
	text = """[center][font_size=320]""" + str(Score) + """[/font_size] 
Codeblocks Finished!"""
	
	if Score == 6:
		Score = 0
		emit_signal("NewGameReq")
