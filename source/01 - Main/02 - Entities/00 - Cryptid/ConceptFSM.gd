# Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
# Signals
#------------------------------------------------------------------------------#
# Variables
# OnReady Variables
@onready var cryptid: Cryptid = $"../../.."
@onready var concept: Node2D = $".."
@onready var concept_label: Label = cryptid.get_node("Outputs/Concept")
#------------------------------------------------------------------------------#
# Ready Method
func _ready() -> void:
	# Add States
	state_add("essence")
	state_add("rumor")
	state_add("glimpse")
	state_add("revealed")
	state_add("manifested")
	call_deferred("state_set", states.essence)
#------------------------------------------------------------------------------#
# State Machine
# State Logistics
func state_logic(_delta):
	match(state):
		states.essence: pass
# State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		states.essence:
			if concept.stage == "Rumor": return states.rumor
			if concept.stage == "Glimpse": return states.glimpse
			if concept.stage == "Revealed": return states.revealed
			if concept.stage == "Manifested": return states.manifested
		states.rumor: if concept.stage == "Glimpse": return states.glimpse
		states.glimpse: if concept.stage == "Revealed": return states.revealed
		states.revealed: if concept.stage == "Manifested": return states.manifested
	return null
# Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.essence, states.rumor:
			if concept.stage == "Essence" || concept.stage == "Rumor":
				cryptid.sprite_base.texture = Textures.CRYPTIDS[concept.stage]
		states.glimpse: cryptid.concept.subtype.match_glimpse()
		states.revealed: cryptid.concept.subtype.match_revealed()
	concept_label.text = str(states.keys()[new_state])
	if old_state != null:
		var old_string = str(states.keys()[old_state])
		var new_string = str(states.keys()[new_state])
		print("Concept State: [%s] -> [%s]" % [old_string, new_string])
# Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.essence: pass
