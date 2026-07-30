extends Node2D
#------------------------------------------------------------------------------#
#Variables
# OnReady Variables
@onready var bottom_screen = $"../.."
#------------------------------------------------------------------------------#
# Bottom Arrows
func left_pressed(): if [bottom_screen.spooki_fsm.states.game_select].has(
	bottom_screen.spooki_fsm.state): select_game("Previous")
func right_pressed(): if [bottom_screen.spooki_fsm.states.idle].has(
	bottom_screen.spooki_fsm.state): select_game("Next")
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
		establish_neighbors()
	else:
		for slot in slot_container.get_children(): slot.queue_free()
		bottom_screen.spookivice.outputs.game_select = false
#Establish Neighbors
func establish_neighbors():
	var slots: Array[Node] = bottom_screen.slot_container.get_children()
	var total_slots: int = slots.size()
	if total_slots <= 1: return
	for index in range(total_slots):
		var current_button: TextureButton = slots[index].get_node("SlotButton")
		var next_index: int = (index + 1) % total_slots
		var previous_index: int = (index - 1 + total_slots) % total_slots
		var next_button: TextureButton = slots[next_index].get_node("SlotButton")
		var previous_button: TextureButton = slots[previous_index].get_node("SlotButton")
		current_button.focus_next = current_button.get_path_to(next_button)
		current_button.focus_previous = current_button.get_path_to(previous_button)
# Grab Focus
func select_game(direction: String):
	var slot_container: HBoxContainer = bottom_screen.slot_container
	if slot_container.get_child_count() == 0: return
	var current_focus: Control = get_viewport().gui_get_focus_owner()
	if current_focus && slot_container.is_ancestor_of(current_focus):
		var target_path: NodePath
		match(direction):
			"Previous": target_path = current_focus.focus_previous
			"Next": target_path = current_focus.focus_next
		if !target_path.is_empty():
			var button_to_focus: TextureButton = current_focus.get_node(target_path)
			if button_to_focus:
				button_to_focus.grab_focus()
				return
	else:
		var first_button: TextureButton = slot_container.get_child(0).get_node("SlotButton")
		if first_button: first_button.grab_focus()
#------------------------------------------------------------------------------#
# Custom Signaled Functions
# Cross Pressed
func cross_pressed():
	spawn_games(false)
	bottom_screen.spookivice.outputs.game_active = false
	for game in Games.get_children(): game.queue_free()
