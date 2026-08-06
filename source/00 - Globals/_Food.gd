extends Node
#------------------------------------------------------------------------------#
# Globals Constants
const SLOT = preload("uid://wamq0p3cddv0")
const NOTEBOOK = preload("uid://fftnyo3s3q8x")
const NOTEBOOK_BOTTOM = preload("uid://bqt6j5srfdf7p")
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
	"Blood": "[wave][color=3e1c2b]Blood[/color][/wave]",
	"Book": "[wave][color=3e1c2b]Book[/color][/wave]",
	"Brains": "[wave][color=3e1c2b]Brains[/color][/wave]",
	"Energy": "[wave][color=3e1c2b]Energy[/color][/wave]",
	"Goat": "[wave][color=3e1c2b]Goat[/color][/wave]",
	"Leaf": "[wave][color=3e1c2b]Leaf[/color][/wave]",
	"Meat": "[wave][color=3e1c2b]Meat[/color][/wave]",
	"Valuables": "[wave][color=3e1c2b]Valuables[/color][/wave]"
}
# Food Descriptions
var DESCRIPTIONS: Dictionary = {
	"Blood": "Composed of red and white cells suspended in plasma, blood is mostly water and contains proteins, glucose, minerals, and hormones all neccessary for a Cryptid's \"natual\" development.\n\nBlood is especially enjoyed by Ghouls, Shadows, and Vampires.",
	"Book": "Written works of volume created by one or more authors, books are broadly classified into fiction with invented narratives, and non-fiction intended as factual truth.\n\nAngels, Ghosts, and Mummies sometimes prefer knowledge over bio-material.",
	"Brains": "An organ that serves as the center of the nervous system in all vertebrates and most invertebrates.\n\nBrains contain Docosahexaenoic Acid (DHA), an Omega-3 Fatty Acid crucial for certain Cryptid development such as Ghouls and Zombies.",
	"Energy": "As the quantifiable property that is transferred to a body or to a physical system, energy is a conserved quantity, one that can be converted in form, but not created or destroyed.\n\nGhosts, Shadows, and Mummies especially thrive on energy.",
	"Goat": "In the era of the Temple of Jerusalem a pair of Capra Hircus were present in rituals. One, the Scapegoat, would be released, believing to hold all the sins of the people while the other was sacrificed.\n\nGrims and Ghouls are simply fond of the taste...",
	"Leaf": "The principal appendage of the stem of a vascular plant, specializing in photosynthesis. Leaves are collectively called \"foliage\".\n\nCertain leaves have been known to be the preferred snack of Cryptids belonging to the Lepidoptera Order",
	"Meat": "Humans have hunted and farmed other animals for meat since prehistory. The Neolithic Revolution allowed the domestication of vertebrates, starting around 11 millenia ago.\n\nThis unidentified meat will serve well as food for Ghouls, Grims, and Zombies, amongst others...",
	"Valuables": "Intelligent creatures often possess an insatiable desire for material gain motivated by the promotion of personal or familial survival or an intent to deny or obstruct competitors from potential means.\n\nGhosts, Mummies, and Vampires are no exception to this."
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
