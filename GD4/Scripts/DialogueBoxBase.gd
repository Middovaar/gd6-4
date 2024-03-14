extends NinePatchRect

const Invisible = Color.TRANSPARENT
const Visible = Color.ANTIQUE_WHITE

var InteractableDialogues:Dictionary = {
	"Spisen": 
		"""I am not hungry right now.""",
	"Dator": 
		"""My computer. I cherish it dearly""",
		
	"Dörr": 
		"""It's too late to go outside.""",
	"DörrPartTwo":
		"""While I'd like a late-night promenade, I can't do that right now.""",
	
	"JackaEtt": 
		"""I bought this jacket, I'd wear it should I go outside.""",
		
	"JackaTvå": 
		"""My mother bought me this jacket. I keep it up here for her.""",
	
	"Horusbild": 
		"""Horus, the Ancient Egyptian god of the sky.""",
	"HorusbildPartTwo":
		"""I recieved it as a birthday gift from Simon""",
	"HorusbildPartThree":
		"""...""",
	"HorusbildPartFour":
		"""...I sometimes hear his voice...""",
		
	"Byrå": 
		""" """,
	"Garderob": 
		""" """,
	"Säng":
		""" """,
}

func _ready():
	modulate = Invisible



func _on_interactables_info(IsOverInteractableAndInteractableID):
	if IsOverInteractableAndInteractableID.x != 0:
		match IsOverInteractableAndInteractableID.y:
			0:
				# Spisen
				pass
			1:
				## Datastol
				pass
			2:
				# Dator
				pass
			3:
				# Dörr
				pass
			4:
				# Jacka 1
				pass
			5:
				# Jacka 2
				pass
			6:
				# Horusbild
				pass
			7:
				# Byrå
				pass
			8:
				# Garderob
				pass
			9:
				# Säng
				pass
