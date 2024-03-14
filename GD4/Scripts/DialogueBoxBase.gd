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
	"Spisen": 
		"""I am not hungry right now.""",
	
	"Datastol":
		"""I really should stop procrastinating""",
	
	"Dator": 
		"""My computer. I cherish it dearly""",
		
	"Dörr1": 
		"""It's too late to go outside.""",
	"Dörr3":
		"""While I'd like a late-night promenade, I can't do that right now.""",
	
	"JackaEtt1": 
		"""I bought this jacket, I love wearing it outside.""",
	"JackaEtt3":
		"""[wave amp=50.0 freq=5.0 connected=1][color=#F0FFF0]So soooooft~[/color][/wave]""",
		
	"JackaTvå": 
		"""My mother bought me this jacket. Now I keep it up here for her.""",
	
	"Horusbild0": 
		"""[shake rate=30.0 level=6 connected=1][color=DC143C]... Dua Horus.[/color][/shake]""",
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
		"""Where do they even get Ol-... [color=EEE8AA]Olanzapine?[/color]""",
		
	"Garderob1": 
		"""Clothes, clothes, and more clothes.""",
	"Garderob2": 
		"""There are memories here.""",
	"Garderob3": 
		"""You know, I really should clean up this place. There's so much junk""",
	"Garderob4": 
		"""Oh... You know, I never wanted to be the school's Lucia. Rather, if I had it my way, I'd be a [color=EEE8AA]bird[/color].""",
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
		"""I've got to create a game, a good game, less a fail the course.""",
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
		match IsOverInteractableAndInteractableID.y:
			0:
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				$Text.set_text(InteractableDialogues["Spisen"])
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 1:
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			1:
				## Datastol
				if %YesNo.modulate == Invisible:
					modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				$Text.set_text(InteractableDialogues["Datastol"])
				print(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])
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
				$Text.set_text(InteractableDialogues["Dator"])
				print(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			3:
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				print(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] > 3:
						HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					$Text.set_text(InteractableDialogues["Dörr" + str(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])])
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			4:
				# Jacka 1
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				print(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])
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
				$Text.set_text(InteractableDialogues["JackaTvå"])
				print(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			6:
				# Horusbild
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				print(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])
				
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
				print(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])
				if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] % 2 == 0:
					modulate = Invisible
					InADialogueRightNow = false
					emit_signal("InDialogue", InADialogueRightNow)
					if HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] > 4:
						HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] = 0
					
				else:
					$Text.set_text(InteractableDialogues["Byrå" + str(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])])
					InADialogueRightNow = true
					emit_signal("InDialogue", InADialogueRightNow)
			8:
				# Garderob
				modulate = Visible
				HowManyTimesInteracted[IsOverInteractableAndInteractableID.y] += 1
				print(HowManyTimesInteracted[IsOverInteractableAndInteractableID.y])
				
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
