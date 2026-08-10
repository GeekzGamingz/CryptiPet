# Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
# Variables
# OnReady Variables
@onready var cryptid: CharacterBody2D = $"../.."
@onready var state_label: Label = cryptid.get_node("Outputs/States")
#------------------------------------------------------------------------------#
# Ready Method
func _ready() -> void:
	# Add States
	state_add("forming")
	state_add("morphing")
	state_add("idle")
	state_add("walk_left")
	state_add("walk_right")
	state_add("walk_up")
	state_add("walk_down")
	state_add("hiding")
	call_deferred("state_set", states.forming)
#------------------------------------------------------------------------------#
# State Machine
# State Logistics
func state_logic(_delta):
	if ![states.forming, states.morphing, states.hiding].has(state):
		cryptid.movement.handle_movement()
		cryptid.movement.apply_movement()
	match(state):
		states.idle: pass
# State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		#Idle
		states.forming: 
			if cryptid.hiding: return states.hiding
			if cryptid.concept.stage != "Essence": return states.morphing
		states.morphing: if !cryptid.sprite_player.is_playing(): return states.idle
		states.idle: return basic_movement()
		states.walk_left: return basic_movement()
		states.walk_right: return basic_movement()
		states.walk_up: return basic_movement()
		states.walk_down: return basic_movement()
	return null
# Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.forming:
			cryptid.sprite_player.play("transform")
			if cryptid.concept.stage == "Essence":
				await cryptid.sprite_player.animation_finished
				cryptid.sprite_player.play("idle")
		states.morphing: cryptid.sprite_player.play("transform")
		states.idle: cryptid.sprite_player.play("idle")
		states.walk_left:
			cryptid.sprite_player.play("walk")
			cryptid.sprite_base.flip_h = false
		states.walk_right:
			cryptid.sprite_player.play("walk")
			cryptid.sprite_base.flip_h = true
		states.walk_up:
			cryptid.sprite_player.play("walk")
			cryptid.sprite_base.flip_h = false
		states.walk_down:
			cryptid.sprite_player.play("walk")
			cryptid.sprite_base.flip_h = true
		states.hiding:
			if cryptid.concept.stage != "Essence": cryptid.sprite_player.play("escape")
			else: cryptid.sprite_player.play_backwards("transform")
	state_label.text = str(states.keys()[new_state])
	#if old_state != null:
		#var old_string = str(states.keys()[old_state])
		#var new_string = str(states.keys()[new_state])
		#print("Switch States: [%s] -> [%s]" % [old_string, new_string])
# Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.idle: pass
#------------------------------------------------------------------------------#
# Custom Functions
func basic_movement() -> int:
	if cryptid.hiding: return states.hiding
	elif cryptid.velocity.x > 0: return states.walk_right
	elif cryptid.velocity.x < 0: return states.walk_left
	elif cryptid.velocity.y > 0: return states.walk_down
	elif cryptid.velocity.y < 0: return states.walk_up
	return states.idle
