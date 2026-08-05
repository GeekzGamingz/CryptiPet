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
@onready var bottom_food: Node2D = $Scripts/Food
#------------------------------------------------------------------------------#
func _ready() -> void:
	await get_tree().process_frame
	spookivice.buttons.connect("left_pressed", _on_left_button_up.bind("Main"))
	spookivice.buttons.connect("right_pressed", _on_right_button_up.bind("Main"))
#------------------------------------------------------------------------------#
# Signaled Functions
# Left/Right Buttons Pressed
func _on_left_button_up(source: String = "Bottom") -> void:
	var states = spooki_fsm.states
	if [states.idle].has(spooki_fsm.state) && source != "Main": switch_tabs("Previous")
	elif [
		states.game_select,
		states.game_active,
		states.food_select
	].has(spooki_fsm.state): select_slot("Previous")
func _on_right_button_up(source: String = "Bottom") -> void:
	var states = spooki_fsm.states
	if [spooki_fsm.states.idle].has(spooki_fsm.state) && source != "Main": switch_tabs("Next")
	elif [
		states.game_select,
		states.game_active,
		states.food_select
	].has(spooki_fsm.state): select_slot("Next")
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
# Grab Focus
func select_slot(direction: String) -> void:
	if slot_container.get_child_count() == 0: return
	var current_focus: Control = get_viewport().gui_get_focus_owner()
	if current_focus && slot_container.is_ancestor_of(current_focus):
		var target_path: NodePath
		match(direction):
			"Previous": target_path = current_focus.focus_previous
			"Next": target_path = current_focus.focus_next
		if !target_path.is_empty():
			var button_to_focus: TextureButton = current_focus.get_node_or_null(target_path)
			if button_to_focus:
				button_to_focus.grab_focus()
				return
	else:
		var first_button: TextureButton = slot_container.get_child(0).get_node_or_null("SlotButton")
		if first_button: first_button.grab_focus()
