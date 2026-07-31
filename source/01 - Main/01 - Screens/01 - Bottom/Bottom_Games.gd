extends Node2D
#------------------------------------------------------------------------------#
#Variables
# OnReady Variables
@onready var bottom_screen = $"../.."
#------------------------------------------------------------------------------#
# Ready
func _ready() -> void:
	await get_tree().process_frame
	bottom_screen.spooki_fsm.connect("start_game_select", spawn_games.bind(true))
	bottom_screen.spookivice.buttons.connect("cross_pressed", cross_pressed)
	bottom_screen.spookivice.buttons.connect("circle_pressed", circle_pressed)
#------------------------------------------------------------------------------#
# Spawn Games
func spawn_games(to_spawn: bool) -> void:
	var slot_container = bottom_screen.slot_container
	if to_spawn:
		for slot in Games.GAMES:
			# Instantiate/Add Slots
			var game_slot = Games.GAME_SLOT.instantiate()
			game_slot.game = slot
			game_slot.name = game_slot.game
			game_slot.top_screen = bottom_screen.spookivice.top_screen
			game_slot.bottom_screen = bottom_screen
			slot_container.add_child(game_slot)
			# Await One Frame to Grab Focus
			await get_tree().process_frame
			if slot_container.get_child_count() > 0:
				var first_slot = slot_container.get_child(0)
				var first_button = first_slot.get_node("SlotButton")
				first_button.grab_focus()
		bottom_screen.establish_neighbors()
	else:
		for slot in slot_container.get_children(): slot.free()
		bottom_screen.spookivice.outputs.game_select = false
#------------------------------------------------------------------------------#
# Custom Signaled Functions
# Cross Pressed
func cross_pressed() -> void:
	spawn_games(false)
	bottom_screen.spookivice.outputs.game_active = false
	for game in Games.get_children(): game.queue_free()
# Circle Pressed
func circle_pressed() -> void:
	if [bottom_screen.spooki_fsm.states.game_select].has(bottom_screen.spooki_fsm.state):
		get_viewport().gui_get_focus_owner().emit_signal("button_up")
	
