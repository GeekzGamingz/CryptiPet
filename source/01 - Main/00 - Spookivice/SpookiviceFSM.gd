# Inherits StateMachine Code
extends StateMachine
#------------------------------------------------------------------------------#
# Signals
signal start_game_select
signal start_food_select
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
	state_add("game_select")
	state_add("game_active")
	state_add("food_select")
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
			if outputs.game_select: return states.game_select
			if outputs.food_select: return states.food_select
		states.waiting:
			if !outputs.powered_on: return states.powering_off
			if !outputs.waiting: return states.idle
		states.food_select:
			if !outputs.powered_on: return states.powering_off
			if !outputs.food_select: return states.idle
		states.game_select:
			if !outputs.powered_on: return states.powering_off
			if !outputs.game_select: return states.idle
			if outputs.game_active: return states.game_active
		states.game_active:
			if !outputs.powered_on: return states.powering_off
			if !outputs.game_active: return states.idle
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
		states.idle:
			outputs.orphanage.awaken()
			outputs.bottom_screen.texture = outputs.bottom_screen._BOTTOM_ON
		states.waiting:
			outputs.disable_buttons(true)
			outputs.disable_choice(false)
			spookivice.texture_player.play("alert")
		states.food_select:
			outputs.top_screen.menu_container.hide()
			outputs.top_screen.info.show()
			outputs.disable_menu(true)
			outputs.orphanage.sleep()
			outputs.bottom_screen.scroll_container.show()
			emit_signal("start_food_select")
		states.game_select:
			outputs.top_screen.menu_container.hide()
			outputs.disable_menu(true)
			outputs.bottom_screen.scroll_container.show()
			outputs.orphanage.sleep()
			emit_signal("start_game_select")
		states.game_active:
			outputs.top_screen.menu_container.hide()
			outputs.disable_menu(true)
			outputs.bottom_screen.scroll_container.show()
		states.powering_off:
			outputs.disable_buttons(true)
			spookivice.notifier.add_message("Powering [Off]", 2.5, true)
			if Games.get_child_count() > 0: for game in Games.get_children(): game.free()
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
		states.game_select, states.food_select:
			outputs.top_screen.menu_container.show()
			outputs.top_screen.info.hide()
			outputs.disable_menu(false)
			outputs.bottom_screen.scroll_container.hide()
		states.game_active:
			outputs.top_screen.menu_container.show()
			outputs.disable_menu(false)
			outputs.bottom_screen.scroll_container.hide()
		states.idle: pass
