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
) var stage: int = 3:
	set(new_stage):
		stage = max(new_stage, 0)
		if is_node_ready(): side_effects()
# OnReady Variables
# Main Nodes
@onready var spookivice: Control = get_tree().get_root().get_node("Spookivice")
# Local Nodes
@onready var subtype: Node2D = $"../Concept/Subtype"
#------------------------------------------------------------------------------#
# Custom Functions
func side_effects() -> void:
	if subtype != null: subtype.update_path()
	if spookivice != null: spookivice.moodifier.add_mood("Happiness", stage, 10)
	print("Happiness: ", str(stage))
