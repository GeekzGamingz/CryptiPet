extends Node2D
#------------------------------------------------------------------------------#
# Variables
# OnReady Variables
@onready var bottom_screen = $"../.."
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	await get_tree().process_frame
	bottom_screen.spooki_fsm.connect("start_shop_select", spawn_shop.bind(true))
	bottom_screen.spookivice.buttons.connect("cross_pressed", cross_pressed)
	bottom_screen.spookivice.buttons.connect("circle_pressed", circle_pressed)
	bottom_screen.spookivice.top_screen.button_time.connect("switch_time", switch_time)
#------------------------------------------------------------------------------#
# Custom Functions
# Spawn Games
func spawn_shop(to_spawn: bool) -> void:
	var slot_container = bottom_screen.slot_container
	if to_spawn:
		for item in Shop.ICONS:
			# Instantiate/Add Slots
			var item_slot = Shop.SLOT.instantiate()
			item_slot.item = item
			item_slot.top_screen = bottom_screen.spookivice.top_screen
			item_slot.bottom_screen = bottom_screen
			slot_container.add_child(item_slot)
			# Await One Frame to Grab Focus
			await get_tree().process_frame
			if slot_container.get_child_count() > 0:
				var first_slot = slot_container.get_child(0)
				var first_button = first_slot.get_node("SlotButton")
				first_button.grab_focus()
		bottom_screen.establish_neighbors()
	else:
		for slot in slot_container.get_children(): slot.free()
		bottom_screen.spookivice.outputs.bartering = false
#------------------------------------------------------------------------------#
# Custom Signaled Functions
# Cross Pressed
func cross_pressed() -> void:
	var spooki_state = bottom_screen.spooki_fsm.states
	if [spooki_state.bartering].has(bottom_screen.spooki_fsm.state):
		spawn_shop(false)
		bottom_screen.spookivice.outputs.bartering = false
# Circle Pressed
func circle_pressed() -> void:
	var spooki_state = bottom_screen.spooki_fsm.states
	if [spooki_state.bartering].has(bottom_screen.spooki_fsm.state):
		get_viewport().gui_get_focus_owner().emit_signal("button_up")
# Switch Time
func switch_time(time: String) -> void: if time == "Night": spawn_shop(false)
#------------------------------------------------------------------------------#
