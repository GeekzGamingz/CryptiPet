extends Node
#------------------------------------------------------------------------------#
# Globals Constants
const FOOD_SLOT = preload("uid://wamq0p3cddv0")
#------------------------------------------------------------------------------#
# Global Variables
# Global Dictionaries
# Food Icons
var FOOD: Dictionary = {
	"Blood": preload("uid://dx1eblie1dy3q"),
	"Book": preload("uid://cris0agwcil73"),
	"Brains": preload("uid://b8ykpa02v0ky0"),
	"Energy": preload("uid://bl5oxxi1rakft"),
	"Goat": preload("uid://b35u8kdbk4prn"),
	"Leaf": preload("uid://ccdgaiuaec6mf"),
	"Meat": preload("uid://nud065t7kmbx"),
	"Valuables": preload("uid://fjskg7j0pf8h")
}
# Foods Consumed
var EATEN: Dictionary = {
	"Blood": 0, "Book": 0, "Brains": 0, "Energy":0,
	"Goat": 0, "Leaf": 0, "Meat": 0, "Valuables": 0
}
# Cryptid Diets
var DIET: Dictionary = {
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
