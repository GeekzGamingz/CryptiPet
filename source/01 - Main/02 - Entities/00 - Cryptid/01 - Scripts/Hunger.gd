extends Node2D
## [Cryptid] Hunger
##
## This node manages the [Cryptid]'s Hunger and its reactions to those [enum stage]s.
#------------------------------------------------------------------------------#
# Variables
# Dictionaries
# Foods Consumed
var eaten: Dictionary = {
	"Blood": 0, "Book": 0, "Brains": 0, "Energy":0,
	"Goat": 0, "Leaf": 0, "Meat": 0, "Valuables": 0
}
# Cryptid Diets
var diet: Dictionary = {
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
# Exported Variables
# Exported Enums
## Sets the Hunger [enum stage] of the player's [Cryptid] to the specified [String];[br]
## Hunger can greatly affect the [enum happiness] of the [Cryptid] and how it evolves.[br][br]
## Default = "Satiated"
@export_enum(
	"Starving",
	"Ravenous",
	"Famished",
	"Peckish",
	"Nibbly",
	"Content",
	"Satiated",
	"Full"
) var stage: String = "Satiated": 
	set(new_stage):
		stage = new_stage
		print("Hunger: ", stage)
