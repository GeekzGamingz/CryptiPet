extends Node2D
## [Cryptid] Hunger
##
## This node manages the [Cryptid]'s Hunger and its reactions to those [enum stage]s.
#------------------------------------------------------------------------------#
# Variables
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
