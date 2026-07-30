extends Node2D
#------------------------------------------------------------------------------#
#Variables
# OnReady Variables
@onready var bottom_screen = $"../.."
#------------------------------------------------------------------------------#
# Spawn Games
func spawn_games(to_spawn: bool) -> void:
	var slot_container = bottom_screen.slot_container
	match(to_spawn):
		true:
			for slot in Games.GAMES:
				# Instantiate/Add Slots
				var game_slot = Games.GAME_SLOT.instantiate()
				game_slot.game = slot
				game_slot.top_screen = bottom_screen.spookivice.top_screen
				game_slot.bottom_screen = bottom_screen
				slot_container.add_child(game_slot)
				# Await One Frame to Grab Focus
				await get_tree().process_frame
				if slot_container.get_child_count() > 0:
					var first_slot = slot_container.get_child(0)
					var first_button = first_slot.get_node("SlotButton")
					first_button.grab_focus()
			establish_neighbors()
		false:
			for slot in slot_container.get_children(): slot.queue_free()
			bottom_screen.spookivice.outputs.game_select = false
# Change Game Selection
func select_game(direction: String):
	match(direction):
		"Previous": pass
		"Next": pass
	print(direction)
# Establish Game Select Neighbors
func establish_neighbors(): pass
#------------------------------------------------------------------------------#
# Custom Signaled Functions
# Cross Pressed
func cross_pressed():
	spawn_games(false)
	bottom_screen.spookivice.outputs.game_active = false
	for game in Games.get_children(): game.queue_free()
