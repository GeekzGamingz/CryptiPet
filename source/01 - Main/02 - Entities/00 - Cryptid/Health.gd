extends Node2D
## [Cryptid] Hunger
##
## This node manages the [Cryptid]'s Health and its reactions to those [enum stage]s.
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
# Exported Enums
## Sets the Health [enum stage] of the player's [Cryptid] to the specified [String];[br]
## Health can greatly affect the [enum happiness] of the [Cryptid] and how it evolves.[br][br]
## Default = "Fit"
@export_enum("Fit", "Ill") var stage: String = "Fit": 
	set(new_stage):
		stage = new_stage
		print("Health: ", new_stage)
