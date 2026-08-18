extends Node2D
## [Cryptid] Concept
##
## This node manages the [Cryptid]'s Concept and how strong it has become.
#------------------------------------------------------------------------------#
# Variables
#var time_transitioning: bool = false
# Exported Variables
@export var base_time: float
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
	"Manifested"
) var stage: String = "Essence":
	set(new_stage):
		stage = new_stage
		print("Concept: ", new_stage)
		if new_stage == "Glimpse": subtype.path_chosen = true
# OnReady Variables
# Main Nodes
@onready var spookivice: Control = get_tree().get_root().get_node("Spookivice")
# Local Nodes
@onready var cryptid: Cryptid = $"../.."
@onready var subtype: Node2D = $Subtype
@onready var morph_timer: Timer = cryptid.get_node("Timers/Morph")
#------------------------------------------------------------------------------#
# Functions
# Ready Functions
func _ready() -> void:
	# Connections
	spookivice.buttons.connect("cross_pressed", reset.bind(true))
	spookivice.buttons.connect("circle_pressed", metamorph)
	# Get Global Times
	morph_timer.wait_time = Globals.CONCEPT_TIME
	morph_timer.start()
	print("New Morph Time: [%ss]" % morph_timer.wait_time)
#------------------------------------------------------------------------------#
# Signaled Functions
# Morph Timeout
func _on_morph_timeout() -> void:
	spookivice.outputs.waiting = true
	match(stage):
		"Essence": spookivice.notifier.add_message("Rumors are spreading... Allow them?", INF, true)
		"Rumor": spookivice.notifier.add_message("They caught a Glimpse! Let them live?", INF, true)
		"Glimpse": spookivice.notifier.add_message("It's about to be Revealed! Make it so?", INF, true)
		"Revealed": spookivice.notifier.add_message("Allow your Cryptid to be Manifested?", INF, true)
#------------------------------------------------------------------------------#
func metamorph():
	if spookivice.outputs.waiting:
		#time_transitioning = true
		match(stage):
			"Essence":
				Globals.CONCEPT = "Rumor"
				Globals.CONCEPT_TIME = base_time * 5
				stage = "Rumor"
			"Rumor":
				Globals.CONCEPT = "Glimpse"
				Globals.CONCEPT_TIME = base_time * 10
				stage = "Glimpse"
			"Glimpse":
				Globals.CONCEPT = "Revealed"
				Globals.CONCEPT_TIME = base_time * 15
				stage = "Revealed"
			"Revealed":
				Globals.CONCEPT = "Manifested"
				Globals.CONCEPT_TIME = base_time * 30
				stage = "Manifested"
			"Manifested": pass
		Globals.CONCEPT = cryptid.concept.stage
		Globals.HAPPINESS = cryptid.happiness.stage
		Globals.HUNGER = cryptid.hunger.stage
		Globals.HEALTH = cryptid.health.fit
		reset(false)
func reset(canceling: bool):
	if spookivice.outputs.waiting:
		if canceling:
			match(stage):
				"Essence": Globals.CONCEPT_TIME = base_time
				"Rumor": Globals.CONCEPT_TIME = base_time * 5
				"Glimpse": Globals.CONCEPT_TIME = base_time * 10
				"Revealed": Globals.CONCEPT_TIME = base_time * 15
				"Manifested": Globals.CONCEPT_TIME = base_time * 30
		morph_timer.wait_time = Globals.CONCEPT_TIME
		morph_timer.start()
		spookivice.notifier.clear_messages()
		spookivice.outputs.waiting = false
		print("Resetting Morph: [%ss]" % morph_timer.wait_time)
