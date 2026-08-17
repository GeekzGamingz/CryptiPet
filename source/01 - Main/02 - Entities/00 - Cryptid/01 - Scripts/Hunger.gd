extends Node2D
## [Cryptid] Hunger
##
## This node manages the [Cryptid]'s Hunger and its reactions to those [enum stage]s.
#------------------------------------------------------------------------------#
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
) var stage: int = 6: 
	set(new_stage):
		stage = new_stage
		if subtype != null: subtype.update_path()
		spookivice.moodifier.add_mood("Hunger", stage, 10)
		print("Hunger: ", stage)
# OnReady Variables
# Main Nodes
@onready var spookivice: Control = get_tree().get_root().get_node("Spookivice")
# Local Nodes
@onready var cryptid: Cryptid = $"../.."
@onready var subtype: Node2D = $"../Concept/Subtype"
@onready var hunger_timer: Timer = $"../../Timers/Hunger"
#------------------------------------------------------------------------------#
# Signaled Functions
func _on_hunger_timeout() -> void:
	if stage > 0: stage -= 1
	hunger_timer.start()
