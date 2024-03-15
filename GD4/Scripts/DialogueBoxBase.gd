extends NinePatchRect

const Invisible = Color.TRANSPARENT
const Visible = Color.ANTIQUE_WHITE

signal IsVisible()
signal IsInvisible()

signal InDialogue(InADialogueRightNow)
signal ShowYesNo()
signal LeaveBase()

var InADialogueRightNow:bool = false

var InteractableDialogues:Dictionary = {
	"Spisen1": 
		"""I am not hungry right now.""",
	"Spisen3":
		"""Simon should really start cooking his own food more. Noone can live on just takeout.""",
	"Spisen5":
		"""I like cooking food. It's calming, soothing. I especially like the sound of frying onions""",
	
	"Datastol":
		"""I really should stop procrastinating""",
	
	"Dator1": 
		"""My computer. I cherish it dearly""",
	"Dator2":
		"""Without it, I would be utterly handicapped.""",
	"Dator3":
		"""If I'd had time, I'd contact my friends overseas.""",
	"Dator4":
		"""I like playing [color=EEE8AA]Quild Conflict: 2[/color]""",
	"Dator0":
		"""[color=#F0FFF0]Online one can be anonymous. You don't have to be yourself, you don't have to be [/color][color=EEE8AA]human[/color]""",
		
	"Dörr1": 
		"""It's too late to go outside.""",
	"Dörr3":
		"""While I'd like a late-night promenade, I can't do that right now.""",
	"Dörr5":
		"""While the chances should be [shake rate=30.0 level=6 connected=1][color=EEE8AA]LITTERALLY[/color][/shake] zero, I'd like to believe that there are werewolves outside""",
	"Dörr7":
		"""Or maybe were-birds""",
	"Dörr9":
		"""Were-birds would be a nice thing to see...""",
	"Dörr11":
		"""They'd probably peck me asunder, but you know, maybe there's a chance they'd be nice!""",
	"Dörr13":
		"""Maybe I'd meet a [color=FF7F50]Sha?[/color] [color=gray]Eh- that'd be silly[/color]...""",
	"Dörr15":
		"""[color=gray]If only you'd knock on my door, [shake rate=30.0 level=6 connected=1]Sutekh...[/shake][/color]...""",
		
	"JackaEtt1": 
		"""I bought this jacket, I love wearing it outside.""",
	"JackaEtt3":
		"""[wave amp=50.0 freq=5.0 connected=1][color=#F0FFF0]So soooooft~[/color][/wave]""",
		
	"JackaTvå1": 
		"""My mother bought me this jacket. Now I keep it up here for her.""",
	"JackaTvå3": 
		"""It smells wierd...""",
	
	"Horusbild0": 
		"""[shake rate=30.0 level=6 connected=1][color=Royalblue]... Dua Horus.[/color][/shake]""",
	"Horusbild1": 
		"""Horus, the Ancient Egyptian god of the Sky.""",
	"Horusbild2":
		"""I recieved the poster as a birthday gift from my childhood friend Simon""",
	"Horusbild3":
		"""...""",
	"Horusbild4":
		"""[color=#F0FFF0]...I sometimes hear [color=EEE8AA]his[/color][color=#F0FFF0] voice...[/color]""",
		
	"Byrå1": 
		"""My medication. I take them two times a day""",
	"Byrå3": 
		"""They make me feel like a dead rock.""",
	"Byrå5":
		"""Where from do they even get Ol-... [color=EEE8AA]Olanzapine?[/color]""",
	"Byrå7":
		"""There's a letter here from my sister""",
	"Byrå9":
		"""She's a writer.""",
	"Byrå11":
		"""She's finishing an anthology of a bird-man in postapocalyptic America.""",
	"Byrå13":
		"""I believe it was called [color=EEE8AA]Birds at the End of Time[/color] though I am not sure...""",
	"Byrå15":
		"""I guess our family always had a thing for [color=EEE8AA]birds[/color]...""",
		
	"Garderob1": 
		"""Clothes, clothes, and more clothes.""",
	"Garderob2": 
		"""There are memories here.""",
	"Garderob3": 
		"""You know, I really should clean up this place. There's so much junk""",
	"Garderob4": 
		"""Oh... You know, I never wanted to be the school's Lucia. Rather, if I had it my way, I'd be a [color=FF7F50]Sha[/color].""",
	"Garderob0": 
		"""[color=#F0FFF0]When I was little I used to love dressup...[/color]""",
	
	"Säng1":
		"""I'm not sleepy right now.""",
	"Säng2":
		"""I just woke up.""",
	"Säng3":
		"""Gods help me and my sleep schedule. It's so late!""",
	"Säng4":
		"""I should buy melatonin""",
	"Säng0":
		"""[color=#F0FFF0]Sometimes I hide underneath the duvet like a child. Guess I never grew up, now did I?[/color]""",
	
	"DatastolOpening1":
		"""I have a turn-in [color=EEE8AA]tomorrow morning[/color]""",
	"DatastolOpening2":
		"""I've got to create a game, a good game, lest a fail the course.""",
	"DatastolOpening3":
		"""Gods, it gives me so much [color=EEE8AA]anxiety[/color] just thinking about it...""",
	"DatastolOpening4":
		"""If only...""",
	"DatastolOpening5":
		"""[shake rate=40.0 level=6 connected=1]GGNNNHH[/shake]""",
	"DatastolOpening6":
		"""Ugh, this is stupid. Ok Set, focus. Game. We're making a game.""",
	"DatastolOpening7":
		"""It's [wave amp=50.0 freq=5.0 connected=1][color=#EEE8AA]Crunchtime![/color][/wave]"""
	
}

var HowManyTimesInteracted:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var DatorDialogueCount:int
var HorusDialogueCount:int
var GarderobDialogueCount:int
var SängDialogueCount:int

var DatastolOpening:bool = false

func _ready():
	modulate = Invisible

func _input(event):
	if DatastolOpening and Input.is_action_just_pressed("Jump"):
		_on_when_entering_chair()

func _on_YesNo_no():
	InADialogueRightNow = false
	modulate = Invisible
	emit_signal("InDialogue", InADialogueRightNow)

func _on_interactables_info(IsOverInteractableAndInteractableID):
	if IsOverInteractableAndInteractableID.x != 0 and Input.is_action_just_pressed("Jump") and %YesNo.modulate != Visible:
		%Guy.play("Default")
		
		match IsOverInteractableAndInteractableID.y:
			0:
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] > 4:
						HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					$Text.set_text(InteractableDialogues["Spisen" + str(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])])
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			1:
				## Datastol
				if %YesNo.modulate == Invisible:
					modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				$Text.set_text(InteractableDialogues["Datastol"])
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] == 1:
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] == 2:
					InADialogueRightNow = true
					emit_signal("ShowYesNo")
					emit_signal("InDialogue", InADialogueRightNow)
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] == 3:
					InADialogueRightNow = false
					modulate = Invisible
					emit_signal("InDialogue", InADialogueRightNow)
					HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
			2:
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] > 5:
						HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					DatorDialogueCount += 1
					$Text.set_text(InteractableDialogues["Dator" + str(DatorDialogueCount % 5)])
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			3:
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] > 15:
						HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					$Text.set_text(InteractableDialogues["Dörr" + str(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])])
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			4:
				# Jacka 1
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] > 3:
						HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					$Text.set_text(InteractableDialogues["JackaEtt" + str(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])])
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			5:
				# Jacka 2
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] > 3:
						HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					$Text.set_text(InteractableDialogues["JackaTvå" + str(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])])
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			6:
				# Horusbild
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] > 5:
						HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					HorusDialogueCount += 1
					$Text.set_text(InteractableDialogues["Horusbild" + str(HorusDialogueCount % 5)])
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			7:
				# Byrå
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] > 15:
						HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					$Text.set_text(InteractableDialogues["Byrå" + str(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])])
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			8:
				# Garderob
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] > 5:
						HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					GarderobDialogueCount += 1
					$Text.set_text(InteractableDialogues["Garderob" + str(GarderobDialogueCount % 5)])
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			9:
				# Säng
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] > 5:
						HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					SängDialogueCount += 1
					$Text.set_text(InteractableDialogues["Säng" + str(SängDialogueCount % 5)])
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
	
	if modulate == Visible and Input.is_action_just_pressed("Jump"):
		SoundSender()
		
	if modulate != Visible and Input.is_action_just_pressed("Jump"):
		emit_signal("IsInvisible")

func _on_when_entering_chair():
	DatastolOpening = true
	modulate = Visible
	HowManyTimesInteracted[10] += 1
	match HowManyTimesInteracted[10]:
		1:
			$Text.set_text(InteractableDialogues["DatastolOpening" + str(HowManyTimesInteracted[10])])
		2:
			$Text.set_text(InteractableDialogues["DatastolOpening" + str(HowManyTimesInteracted[10])])
		3:
			$Text.set_text(InteractableDialogues["DatastolOpening" + str(HowManyTimesInteracted[10])])
		4:
			$Text.set_text(InteractableDialogues["DatastolOpening" + str(HowManyTimesInteracted[10])])
		5:
			$Text.set_text(InteractableDialogues["DatastolOpening" + str(HowManyTimesInteracted[10])])
		6:
			$Text.set_text(InteractableDialogues["DatastolOpening" + str(HowManyTimesInteracted[10])])
		7:
			$Text.set_text(InteractableDialogues["DatastolOpening" + str(HowManyTimesInteracted[10])])
		8:
			modulate = Invisible
			DatastolOpening = false
			emit_signal("LeaveBase")

func SoundSender():
	emit_signal("IsVisible")
	await get_tree().create_timer(0.5).timeout
	emit_signal("IsInvisible")
