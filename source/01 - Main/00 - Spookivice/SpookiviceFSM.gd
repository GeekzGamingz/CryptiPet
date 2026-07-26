# Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
# Signals
signal start_game_mode
#------------------------------------------------------------------------------#
# Variables
# OnReady Variables
@onready var spookivice: Control = $".."
@onready var outputs: Node2D = spookivice.get_node("Outputs")
@onready var state_label: Label = spookivice.get_node("Outputs/States")
#------------------------------------------------------------------------------#
# Ready Method
func _ready() -> void:
	# Add States
	state_add("standby")
	state_add("powering_on")
	state_add("idle")
	state_add("waiting")
	state_add("game_mode")
	state_add("powering_off")
	state_add("off")
	call_deferred("state_set", states.standby)
#------------------------------------------------------------------------------#
# State Machine
# State Logistics
func state_logic(_delta):
	match(state):
		states.idle: pass
# State Transitions
@warning_ignore("unused_parameter")
func transitions(delta):
	match(state):
		states.standby: if outputs.powered_on: return states.powering_on
		states.powering_on:
			if !outputs.powered_on: return states.powering_off
			if outputs.spawned: return states.idle
		states.idle:
			if !outputs.powered_on: return states.powering_off
			if outputs.waiting: return states.waiting
			if outputs.game_mode: return states.game_mode
		states.waiting:
			if !outputs.powered_on: return states.powering_off
			if !outputs.waiting: return states.idle
		states.game_mode: if !outputs.powered_on: return states.powering_off
		states.powering_off: if !outputs.spawned: return states.off
	return null
# Enter State
@warning_ignore("unused_parameter")
func state_enter(new_state, old_state):
	match(new_state):
		states.standby: outputs.disable_buttons(true)
		states.powering_on:
			outputs.bottom_screen.phase = "On"
			spookivice.texture_player.play("alert")
			spookivice.notifier.add_message("Powering [On]", 2.5, true)
		states.idle: pass
		states.waiting:
			outputs.disable_buttons(true)
			outputs.disable_choice(false)
			spookivice.texture_player.play("alert")
		states.game_mode:
			outputs.top_screen.menu_container.hide()
			outputs.disable_menu(true)
			outputs.bottom_screen.menu_container.show()
			outputs.orphanage.sleep()
			emit_signal("start_game_mode", true)
		states.powering_off:
			outputs.disable_buttons(true)
			spookivice.notifier.add_message("Powering [Off]", 2.5, true)
		states.off:
			outputs.top_screen.location = "Off"
			outputs.bottom_screen.phase = "Off"
			await get_tree().create_timer(1).timeout
			get_tree().quit()
	state_label.text = str(states.keys()[new_state])
	if old_state != null:
		var old_string = str(states.keys()[old_state])
		var new_string = str(states.keys()[new_state])
		print("Spookivice States: [%s] -> [%s]" % [old_string, new_string])
# Exit State
@warning_ignore("unused_parameter")
func state_exit(old_state, new_state):
	match(old_state):
		states.standby: outputs.disable_buttons(false)
		states.powering_on: spookivice.texture_player.play("standby")
		states.waiting:
			outputs.disable_buttons(false)
			spookivice.texture_player.play("standby")
		states.game_mode: outputs.top_screen.menu_container.show()
		states.idle: pass
