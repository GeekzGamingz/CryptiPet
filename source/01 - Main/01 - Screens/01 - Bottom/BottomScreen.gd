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
@onready var bottom_games: Node2D = $Scripts/Games
#------------------------------------------------------------------------------#
func _ready() -> void:
	await get_tree().process_frame
	spookivice.buttons.connect("left_pressed", _on_left_button_up)
	spookivice.buttons.connect("right_pressed", _on_right_button_up)
#------------------------------------------------------------------------------#
# Signaled Functions
# Left/Right Buttons Pressed
func _on_left_button_up() -> void:
	if [spooki_fsm.states.idle].has(spooki_fsm.state): switch_tabs("Previous")
	elif [spooki_fsm.states.game_select].has(spooki_fsm.state): bottom_games.select_game("Previous")
func _on_right_button_up() -> void:
	if [spooki_fsm.states.idle].has(spooki_fsm.state): switch_tabs("Next")
	elif [spooki_fsm.states.game_select].has(spooki_fsm.state): bottom_games.select_game("Next")
#------------------------------------------------------------------------------#
# Custom Functions
func update_screen() -> void:
	match(phase):
		"On":
			texture = _BOTTOM_ON
			menu_container.set_deferred("visible", true)
		"Off":
			texture = _BOTTOM_OFF
			menu_container.set_deferred("visible", false)
# Switch Tabs
func switch_tabs(direction: String) -> void:
	var tab_size: int = tab_container.get_child_count() - 2 # -1 Aligns Arrays, -1 Excludes [ScrollContainer]
	var shown_tab: int = tab_container.current_tab
	match(direction):
		"Previous": tab_container.current_tab = tab_size if shown_tab == 0 else shown_tab - 1
		"Next": tab_container.current_tab = 0 if shown_tab == tab_size else shown_tab + 1
	print("[%s] Tab: [%s]" % [direction, tab_container.get_current_tab_control().name])
#Establish Neighbors
func establish_neighbors() -> void:
	var slots: Array[Node] = slot_container.get_children()
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
