extends Node2D
## [Cryptid] Concept
##
## This node manages the [Cryptid]'s Concept and how strong it has become.
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
# Exported Enums
## Sets the Concept [enum stage] of the player's [Cryptid] to the specified [String];[br]
## This is the maturity of the creature and will help it evolve into the different stages [br]
## of life as a [Cryptid].[br][br]
## Default = "Essence"
@export_enum(
	"Essence",
	"Rumor",
	"Glimpse",
	"Revealed",
	"Manifesting"
) var stage: String = "Essence":
	set(new_stage):
		stage = new_stage
		if cryptid != null: cryptid.sprite_base.texture = Textures.CRYPTIDS[stage]
		else:
			print("Concept Switching to Global")
			stage = Globals.Concept
		print("Concept: ", stage)
# OnReady Variables
# Local Nodes
@onready var cryptid: Cryptid = $"../.."
@onready var morph: Timer = cryptid.get_node("Timers/Morph")
@onready var spookivice: Control = get_tree().get_root().get_node("Spookivice")
#------------------------------------------------------------------------------#
# Functions
# Ready Functions
func _ready() -> void:
	spookivice.buttons.connect("cross_pressed", cancel)
	spookivice.buttons.connect("circle_pressed", metamorph)
#------------------------------------------------------------------------------#
# Signaled Functions
# Morph Timeout
func _on_morph_timeout() -> void:
	spookivice.outputs.waiting = true
	match(stage):
		"Essence": spookivice.notifier.add_message("Rumors are spreading... Allow them?", INF, true)
		"Rumor": spookivice.notifier.add_message("They caught a Glimpse! Let them live?", INF, true)
#------------------------------------------------------------------------------#
func metamorph(): if spookivice.outputs.waiting: stage = "Rumor" #Change to be modular
func cancel(): if spookivice.outputs.waiting: print("Canceling Morph")
