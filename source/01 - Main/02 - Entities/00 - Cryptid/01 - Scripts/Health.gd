extends Node2D
## [Cryptid] Hunger
##
## This node manages the [Cryptid]'s Health and its reactions to those [enum stage]s.
#------------------------------------------------------------------------------#
# Variables
var hunger_sickness: bool = false:
	set(new_bool):
		if new_bool != hunger_sickness: fit = !new_bool
		hunger_sickness = new_bool
# Exported Variables
# Exported Enums
## Sets the Health [enum stage] of the player's [Cryptid] to the specified [String];[br]
## Health can greatly affect the [enum happiness] of the [Cryptid] and how it evolves.[br][br]
## Default = "Fit"
@export var fit: bool = true: 
	set(new_bool):
		fit = new_bool
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
	if spookivice != null: spookivice.moodifier.add_mood("Health", fit, 10)
	print("Fit: ", fit)
