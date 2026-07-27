extends TextureRect
#------------------------------------------------------------------------------#
const _BOTTOM_OFF = preload("uid://c3u4h1h5ya4h8")
const _BOTTOM_ON = preload("uid://dm5alueyt0wj8")
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
## Sets the Bottom Screen's [enum phase].
@export_enum("On", "Off") var phase = "Off":
	set(new_phase):
		phase = new_phase
		update_screen()
## References the Menu Container [HBoxContainer].
@export var menu_container: HBoxContainer
## References the Countdown [PanelContainer].
@export var countdown_container: MarginContainer
## References the Countdown [RichTextLabel].
@export var countdown: RichTextLabel
## References the Clock [Panel Container].
@export var clock_container: MarginContainer
## References the [ScrollContainer].
@export var scroll_container: ScrollContainer
## References the Slot Container [HBoxContainer].
@export var slot_container: HBoxContainer
# OnReady Variables
# Main Nodes
@onready var spookivice: Control = get_tree().get_root().get_node("Spookivice")
@onready var spooki_fsm: Node2D = spookivice.get_node("StateMachine")
# Local Nodes
@onready var tab_container: TabContainer = $MenuContainer/TabContainer
#------------------------------------------------------------------------------#
# Ready
func _ready() -> void:
	await get_tree().process_frame
	spookivice.fsm.connect("start_game_mode", spawn_games.bind(true))
	spookivice.buttons.connect("cross_pressed", cross_pressed)
#------------------------------------------------------------------------------#
# Signaled Functions
# Left/Right Buttons Pressed
func _on_left_button_up() -> void: toggle_time()
func _on_right_button_up() -> void: toggle_time()
#------------------------------------------------------------------------------#
# Custom Functions
func update_screen():
	match(phase):
		"On":
			texture = _BOTTOM_ON
			menu_container.set_deferred("visible", true)
		"Off":
			texture = _BOTTOM_OFF
			menu_container.set_deferred("visible", false)
# Custom Functions
func toggle_time():
	if ![spooki_fsm.states.game_mode].has(spooki_fsm.state):
		if !countdown_container.visible: countdown_container.show()
		else: clock_container.show()
	else: print("Game Mode Select")
# Spawn Games
func spawn_games(to_spawn: bool) -> void:
	match(to_spawn):
		true: for slot in Games.GAME_SLOTS:
			# Instantiate/Add Slots
			var game_slot = Games.GAME_SLOTS[slot].instantiate()
			game_slot.game = slot
			game_slot.top_screen = spookivice.top_screen
			slot_container.add_child(game_slot)
			# Await One Frame to Grab Focus
			await get_tree().process_frame
			if slot_container.get_child_count() > 0:
				var first_slot = slot_container.get_child(0)
				var first_button = first_slot.get_node("SlotButton")
				first_button.grab_focus()
		false:
			for slot in slot_container.get_children(): slot.queue_free()
			spookivice.outputs.game_mode = false
#------------------------------------------------------------------------------#
# Custom Signaled Functions
# Cross Pressed
func cross_pressed(): spawn_games(false)
