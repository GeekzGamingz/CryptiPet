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
		var increase: bool = true if new_stage > stage else false
		stage = max(new_stage, 0)
		if is_node_ready(): side_effects(increase)
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
	else: cryptid.health.hunger_sickness = true # Ill if Starving
	if stage <= 2: cryptid.happiness.stage -= 1 # At Famished or Below
	hunger_timer.start()
#------------------------------------------------------------------------------#
# Custom Functions
func side_effects(increase):
	if subtype != null: subtype.update_path()
	if spookivice != null: spookivice.moodifier.add_mood("Hunger", stage, 10)
	if increase: cryptid.health.hunger_sickness = false
	print("Hunger: ", stage)
