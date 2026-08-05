extends Node
#------------------------------------------------------------------------------#
# Globals Constants
const SLOT = preload("uid://wamq0p3cddv0")
#------------------------------------------------------------------------------#
# Global Variables
# Global Dictionaries
# Food Icons
var ICONS: Dictionary = {
	"Blood": preload("uid://dx1eblie1dy3q"),
	"Book": preload("uid://cris0agwcil73"),
	"Brains": preload("uid://b8ykpa02v0ky0"),
	"Energy": preload("uid://bl5oxxi1rakft"),
	"Goat": preload("uid://b35u8kdbk4prn"),
	"Leaf": preload("uid://ccdgaiuaec6mf"),
	"Meat": preload("uid://nud065t7kmbx"),
	"Valuables": preload("uid://fjskg7j0pf8h")
}
# Food Titles
var TITLES: Dictionary = {
	"Blood": "[wave][color=171717]Blood[/color][/wave]",
	"Book": "[wave][color=171717]Book[/color][/wave]",
	"Brains": "[wave][color=171717]Brains[/color][/wave]",
	"Energy": "[wave][color=171717]Energy[/color][/wave]",
	"Goat": "[wave][color=171717]Goat[/color][/wave]",
	"Leaf": "[wave][color=171717]Leaf[/color][/wave]",
	"Meat": "[wave][color=171717]Meat[/color][/wave]",
	"Valuables": "[wave][color=171717]Valuables[/color][/wave]"
}
# Food Descriptions
var DESCRIPTIONS: Dictionary = {
	"Blood": "Composed of red and white cells suspended in plasma, blood is mostly water and contains proteins, glucose, minerals, and hormones all neccessary for a Cryptid's natual development.\n\nBlood is especially enjoyed by Ghouls, Shadows, and Vampires.",
	"Book": "A written work of substaintial length created by one or more authors. Books are broadly classified into fiction, which contains invented narratives or other imaginary content, and non-fiction, which contains content intended as factual truth.\n\nAngels, Ghosts, and Mummys often prefer to consume knowledge instead of bio-material.",
	"Brains": "An organ that serves as the center of the nervous system in all vertebrate and most invertebrate animals, the brain cosists of nervous tissue and is typically located in the head due to Cephalization.\n\nBrains contain Docosahexaenoic Acid (DHA), an Omega-3 Fatty Acid crucial for certain Cryptid development.",
	"Energy": "",
	"Goat": "",
	"Leaf": "",
	"Meat": "",
	"Valuables": ""
}
# Cryptid Diets
var DIETS: Dictionary = {
	# Sprits
	"Angel": ["Book"],
	"Ghost": ["Energy", "Book", "Valuables"],
	"Grim": ["Meat", "Goat"],
	"Shadow": ["Energy", "Blood"],
	"Wraith": ["All"],
	# Undead
	"Balbal": ["All"],
	"Ghoul": ["Brains", "Blood", "Goat", "Meat"],
	"Mummy": ["Book", "Energy", "Valuables"],
	"Vampire": ["Blood", "Valuables"],
	"Zombie": ["Brains", "Meat"]
}
# Foods Consumed
var EATEN: Dictionary = {
	"Blood": 0, "Book": 0, "Brains": 0, "Energy":0,
	"Goat": 0, "Leaf": 0, "Meat": 0, "Valuables": 0
}
