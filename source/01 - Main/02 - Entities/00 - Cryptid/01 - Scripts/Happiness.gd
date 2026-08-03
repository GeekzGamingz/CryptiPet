extends Node2D
## [Cryptid] Happiness
##
## This node manages the [Cryptid]'s Happiness and its reactions to those [enum stage]s.
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
# Exported Enums
## Sets the Happiness [enum stage] of the player's [Cryptid] to the specified [String];[br]
## How happy the creature is will depend on how it evolves, when it leaves, or if it dies.[br][br]
## Default = "Neutral"
@export_enum(
	"Hostile",
	"Angry",
	"Frustrated",
	"Neutral",
	"Happy",
	"Elated",
	"Euphoric"
) var stage: String = "Neutral":
	set(new_stage):
		stage = new_stage
		print("Happiness: ", stage)
