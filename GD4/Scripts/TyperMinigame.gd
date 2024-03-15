extends RichTextLabel

var KeypressesAreHappening:bool = false
var Keyboardtimer = 0

var KeyPresserIndex:Vector2i = Vector2i(0,0) #X = number of buttonpresses, Y = Which set are you on
var Filenumber:int
var IsTypable:bool = true
var ClickDamper:int = 0
signal Scorer()

const NewLine = """
	"""

const Indent = """	"""

var Openers:Dictionary = {
	"extends":
		"""[color=crimson]extends[/color] """,
	"0":
		"""[color=lightgreen]Camera2D[/color] 
		
		""",
	"1":
		"""[color=lightgreen]Node2D[/color] 
		
		""",
	"2":
		"""[color=lightgreen]Sprite2D[/color] 
		
		""",
	"3":
		"""[color=lightgreen]AudioStreamPlayer2D[/color] 
		
		""",
	"4":
		"""[color=lightgreen]PointerFootgun2D[/color] 
		
		""",
	"5":
		"""[color=lightgreen]ErnestAdams2D[/color] 
		
		""",
	"6":
		"""[color=lightgreen]ProductiveScrumMeeting2D[/color] 
		
		""",
	"7":
		"""[color=lightgreen]StackOverflow2D[/color] 
		
		""",
	"8":
		"""[color=lightgreen]MDAFramework2D[/color] 
		
		""",
	"9":
		"""[color=lightgreen]NullPointerException2D[/color] 
		
		""",
	"newbase":
	"""[color=lightslategray]# Called when the node enters the scene tree for the first time.[/color] 
	[color=crimson]func[/color] [color=Aquamarine]_ready()[/color]:
		
		[color=deeppink]pass[/color] [color=lightslategray]# Replace with function body.[/color] 
	
	[color=lightslategray]# Called every frame. 'delta' is the elapsed time since the previous frame.[/color] 
	[color=crimson]func[/color] [color=Aquamarine]_process([/color][color=goldenrod]delta[/color][color=Aquamarine])[/color]:
		
		[color=deeppink]pass[/color]
	""",
	"currentbase": """""",
	"nakedreadyfunction":
		"""[color=crimson]func[/color] [color=Aquamarine]_ready()[/color]:""",
	"nakedprocessfunction":
		"""[color=crimson]func[/color] [color=Aquamarine]_process([/color][color=goldenrod]delta[/color][color=Aquamarine])[/color]:""",
}

var CommentDelete:Dictionary = {
	"1":
		"""[color=lightslategray]# Called when the node enters [/color] 
	[color=crimson]func[/color] [color=Aquamarine]_ready()[/color]:
		
		[color=deeppink]pass[/color] [color=lightslategray]# Replace with function body.[/color] 
	
	[color=lightslategray]# Called every frame. 'delta' is the elapsed time since the previous frame.[/color] 
	[color=crimson]func[/color] [color=Aquamarine]_process([/color][color=goldenrod]delta[/color][color=Aquamarine])[/color]:
		
		[color=deeppink]pass[/color]
	""",
	"2":
		"""[color=lightslategray]# Called when[/color] 
	[color=crimson]func[/color] [color=Aquamarine]_ready()[/color]:
		
		[color=deeppink]pass[/color] [color=lightslategray]# Replace with function body.[/color] 
	
	[color=lightslategray]# Called every frame. 'delta' is the elapsed time since the previous frame.[/color] 
	[color=crimson]func[/color] [color=Aquamarine]_process([/color][color=goldenrod]delta[/color][color=Aquamarine])[/color]:
		
		[color=deeppink]pass[/color]
	""",
	"3":
		""" 
	[color=crimson]func[/color] [color=Aquamarine]_ready()[/color]:
		
		[color=deeppink]pass[/color] [color=lightslategray]# Replace with function body.[/color] 
	
	[color=lightslategray]# Called every frame. 'delta' is the elapsed time since the previous frame.[/color] 
	[color=crimson]func[/color] [color=Aquamarine]_process([/color][color=goldenrod]delta[/color][color=Aquamarine])[/color]:
		
		[color=deeppink]pass[/color]
	""",
	"4":
		""" 
	[color=crimson]func[/color] [color=Aquamarine]_ready()[/color]:
		
		[color=deeppink]pass[/color] [color=lightslategray]# Replace with function body.[/color] 
	
	[color=lightslategray]# Called every frame. 'delta' is [/color] 
	[color=crimson]func[/color] [color=Aquamarine]_process([/color][color=goldenrod]delta[/color][color=Aquamarine])[/color]:
		
		[color=deeppink]pass[/color]
	""",
	"5":
		""" 
	[color=crimson]func[/color] [color=Aquamarine]_ready()[/color]:
		
		[color=deeppink]pass[/color] [color=lightslategray]# Replace with function body.[/color] 
	
	 
	[color=crimson]func[/color] [color=Aquamarine]_process([/color][color=goldenrod]delta[/color][color=Aquamarine])[/color]:
		
		[color=deeppink]pass[/color]
	""",
	"6":
		""" 
	[color=crimson]func[/color] [color=Aquamarine]_ready()[/color]:
		
		[color=deeppink]pass[/color] [color=lightslategray]# Replace [/color] 
	
	 
	[color=crimson]func[/color] [color=Aquamarine]_process([/color][color=goldenrod]delta[/color][color=Aquamarine])[/color]:
		
		[color=deeppink]pass[/color]
	""",
	"7":
		""" 
	[color=crimson]func[/color] [color=Aquamarine]_ready()[/color]:
		
		[color=deeppink]pass[/color]  
	
	 
	[color=crimson]func[/color] [color=Aquamarine]_process([/color][color=goldenrod]delta[/color][color=Aquamarine])[/color]:
		
		[color=deeppink]pass[/color]
	""",
}

var Variables:Dictionary = {
	"1":
		"""[color=crimson]var[/color]:[color=Greenyellow]bool[/color] ICantNameVariables 
	""",
	"2":
		"""[color=crimson]var[/color]:[color=Greenyellow]CongregationArray[/color] HaydenIsCute 
	""",
	"3":
		"""[color=crimson]const[/color]:[color=Greenyellow]float[/color] FunnyVariableIHaveNoIdeaWhatThisDoes = [color=Paleturquoise]420[/color]
	""",
	"4":
		"""[color=crimson]var[/color]:[color=Greenyellow]WeeWoo[/color] WeeWooVariable 
	""",
	"5":
		"""[color=crimson]var[/color]:[color=Greenyellow]Vector4.5[/color] HiMom 
	""",
	"6":
		"""[color=crimson]var[/color]:[color=Greenyellow]Null[/color] AVariableIThink 
	""",
	"7":
		"""[color=crimson]var[/color]:[color=Greenyellow]Int[/color] ThisIsABoolTRUSTME 
	""",
	"8":
		"""[color=crimson]const[/color]:[color=Greenyellow]Node[/color] ThisMakeGameGoBRRR = [color=Green]$Baller[/color]
	""",
	"9":
		"""[color=crimson]const[/color]:[color=Greenyellow]String[/color] IfIDeleteThisTheGameBreaks = [color=Goldenrod]"Awaa"[/color]
	""",
	"10":
		"""[color=crimson]const[/color]:[color=Greenyellow]Bool[/color] IfElseIfElseIfElse = [color=crimson]true[/color]
	""",
}
var AddedVariables = """"""

var ReadyCode:Dictionary = {
	"1":
	"""[color=crimson]for[/color] n [color=crimson]in[/color] [color=Paleturquoise]14[/color]
		[color=crimson]var[/color] BigBalls
		[color=crimson]await[/color] [color=Dodgerblue]get_tree[/color]().[color=Dodgerblue]create_timer[/color]([color=Paleturquoise]1.5[/color]).[color=Lightsalmon]timeout[/color]
		[color=Lightsalmon]position[/color].[color=Darkturquoise]x[/color] = [color=Hotpink]OS[/color].[color=Greenyellow]DisplaySystem[/color].[color=Dodgerblue]get_system_clock[/color]().[color=Paleturquoise]delta_eval[/color]
		BigBalls = [color=Lightsalmon]position[/color] / [color=Paleturquoise]14[/color]
	
	""",
	"2":
		"""[color=Mediumpurple]print[/color]([color=Goldenrod]"hi mom!"[/color])
		[color=hotpink]if[/color] [color=crimson]self[/color].[color=Dodgerblue]get_transformed[/color]([color=Green]$Theusa[/color]) != [color=crimson]null[/color]:
			[color=Mediumpurple]print[/color]([color=Goldenrod]"AAAAAAANOOOO"[/color])
			[color=Lightsalmon]position[/color].[color=Darkturquoise]x[/color] = [color=Paleturquoise]-2000[/color]
	""",
	"3":
		"""[color=Dodgerblue]call_grace_func[/color](PleaseDontThrowErrors) -> [color=Greenyellow]Int[/color]
	""",
	"4":
		"""[color=crimson]var[/color] WeeWooVariable = [color=Greenyellow]MDA[/color].[color=Dodgerblue]cause_ludonarriative_dissonance()[/color]
	""",
	"5":
		"""[color=Lightslategray]# Does this actually do somethin or am I just bad?[/color]
	""",
}
var ReadyCodeblocks = """"""
var ProcessCodeblocks = """"""

func _ready():
	Filenumber = randi() % 10
	## I hate that this works
	text = Openers["extends"] + Openers[str(Filenumber)] + """
	"""
	text += Openers["newbase"]
	idle()

func _process(delta):
	if KeypressesAreHappening:
		Keyboardtimer += 1
	if Keyboardtimer >= 100:
		KeypressesAreHappening = false
		Keyboardtimer = 0

func idle():
	await get_tree().create_timer(0.5).timeout
	if !KeypressesAreHappening:
		text = get_text() + "_"
		await get_tree().create_timer(0.5).timeout
		text = get_text().left(-1)
	idle()

func _input(event):
	if event is InputEventKey and event.is_pressed() and IsTypable:
		KeypressesAreHappening = true
		if get_text().right(1) == "_":
			text = get_text().left(-1)
		
		## Detects which Set we're on
		KeyPresserIndex.x += 1
		match KeyPresserIndex.y:
			0: #Remove Premade Comments
				if KeyPresserIndex.x == 1:
						text = get_text().left(-(Openers["newbase"].length()))
						text += CommentDelete[str(KeyPresserIndex.x)]
				if KeyPresserIndex.x > 1 and KeyPresserIndex.x < 8:
						text = get_text().left(-(CommentDelete[str(KeyPresserIndex.x - 1)].length()))
						text += CommentDelete[str(KeyPresserIndex.x)]
						Openers["currentbase"] = get_text().right( -((Openers["extends"] + Openers[str(Filenumber)] + NewLine).length()) )
				if KeyPresserIndex.x == 8:
						KeyPresserIndex.y = 1
						KeyPresserIndex.x = 0
			1: #Adds Variables
				text = Openers["extends"] + Openers[str(Filenumber)] + NewLine + AddedVariables + Openers["currentbase"]
				if KeyPresserIndex.x < 6:
					AddedVariables += Variables[str(randi() % 10 + 1)]
				if KeyPresserIndex.x == 6:
					Openers["currentbase"] = get_text()
					KeyPresserIndex.y = 2
					KeyPresserIndex.x = 0
			2: #Adding actual codeblocks
				text = Openers["extends"] + Openers[str(Filenumber)] + NewLine + AddedVariables + NewLine + Openers["nakedreadyfunction"] + NewLine + ReadyCodeblocks + NewLine + Openers["nakedprocessfunction"] + NewLine + Indent + """[color=deeppink]pass[/color]"""
				if KeyPresserIndex.x < 5:
					ReadyCodeblocks += Indent + ReadyCode[str(randi() % 5 + 1)]
				if KeyPresserIndex.x == 5:
					Openers["currentbase"] = get_text()
					KeyPresserIndex.y = 3
					KeyPresserIndex.x = 0
			3: #Adding process codeblocks
				text = Openers["extends"] + Openers[str(Filenumber)] + NewLine + AddedVariables + NewLine + Openers["nakedreadyfunction"] + NewLine + ReadyCodeblocks + NewLine + Openers["nakedprocessfunction"] + NewLine + ProcessCodeblocks
				if KeyPresserIndex.x < 3:
					ProcessCodeblocks += Indent + ReadyCode[str(randi() % 5 + 1)]
				if KeyPresserIndex.x == 3:
					Openers["currentbase"] = get_text()
					KeyPresserIndex.y = 0
					KeyPresserIndex.x = 0
					IsTypable = false
	if event is InputEventKey and event.is_pressed() and !IsTypable:
		ClickDamper += 1
		if ClickDamper == 3:
			ClickDamper = 0
			emit_signal("Scorer")
			New()
			IsTypable = true

func New():
	
	text = Openers["extends"] + Openers[str(Filenumber)] + """
	"""
	Openers["currentbase"] = get_text()
	AddedVariables = """"""
	ReadyCodeblocks = """"""
	ProcessCodeblocks = """"""
	text += Openers["newbase"]
