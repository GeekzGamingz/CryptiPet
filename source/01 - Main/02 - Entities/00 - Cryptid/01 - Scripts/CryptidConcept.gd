extends Node2D
## [Cryptid] Concept
##
## This node manages the [Cryptid]'s Concept and how strong it has become.
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
@export var base_time: float = 60.0
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
			stage = Globals.CONCEPT
		print("Concept: ", stage)
# OnReady Variables
# Local Nodes
@onready var cryptid: Cryptid = $"../.."
@onready var morph_timer: Timer = cryptid.get_node("Timers/Morph")
@onready var spookivice: Control = get_tree().get_root().get_node("Spookivice")
#------------------------------------------------------------------------------#
# Functions
# Ready Functions
func _ready() -> void:
	spookivice.buttons.connect("cross_pressed", cancel)
	spookivice.buttons.connect("circle_pressed", metamorph)
	morph_timer.wait_time = Globals.CONCEPT_TIME
	print("New Morph Time: [%s]" % morph_timer.wait_time)
#------------------------------------------------------------------------------#
# Signaled Functions
# Morph Timeout
func _on_morph_timeout() -> void:
	spookivice.outputs.waiting = true
	match(stage):
		"Essence": spookivice.notifier.add_message("Rumors are spreading... Allow them?", INF, true)
		"Rumor": spookivice.notifier.add_message("They caught a Glimpse! Let them live?", INF, true)
#------------------------------------------------------------------------------#
func metamorph():
	if spookivice.outputs.waiting:
		match(stage):
			"Essence":
				stage = "Rumor"
				Globals.CONCEPT = "Rumor"
				Globals.CONCEPT_TIME = base_time * 5
			"Rumor":
				stage = "Glimpse"
				Globals.CONCEPT = "Glimpse"
				Globals.CONCEPT_TIME = base_time * 10
			"Glimpse":
				stage = "Revealed"
				Globals.CONCEPT = "Revealed"
				Globals.CONCEPT_TIME = base_time * 15
			"Revealed":
				stage = "Manifested"
				Globals.CONCEPT = "Manifested"
				Globals.CONCEPT_TIME = base_time * 30
			"Manifested": pass
		spookivice.notifier.clear_messages()
		spookivice.outputs.waiting = false
func cancel():
	if spookivice.outputs.waiting: print("Canceling Morph")
