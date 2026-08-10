extends TextureRect
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
## Points to the Spookivice. This is your responsibility... Your curse.
@export var spookivice: Control
## Points to the Menu Container [TabContainer]
@export var tab_container: TabContainer
## Points to the Menu Container [HBoxContainer]
@export var menu_container: HBoxContainer
## Points to the Title [RichTextLabel]
@export var title: RichTextLabel
## Points to the Level [Node2d].
@export var level: Node2D
# Exported Enumerations
## Sets the [enum location] of the player's [Cryptid] to the [Texture2D];[br]
## Depends on the [enum time].[br][br]
## Default = "Off"
@export_enum("Off", "Graveyard") var location = "Off":
	set(new_location):
		location = new_location
		if new_location == "Off": tab_container.hide() 
		else: tab_container.show()
		update_location()
## Sets the [enum time] of the player's [enum location].
@export_enum("Day", "Night") var time = "Night":
	set(new_time):
		time = new_time
		update_location()
# OnReady Variables
# Local Nodes
@onready var spooki_fsm: Node2D = spookivice.get_node("StateMachine")
@onready var button_feed: TextureButton = menu_container.get_node("Feed")
@onready var button_time: TextureButton = menu_container.get_node("Time")
@onready var info: MarginContainer = $InfoContainer
@onready var orphanage: Marker2D = $Orphanage
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	await get_tree().process_frame
	spookivice.toggles.connect("power_toggled", power_toggled)
	spookivice.buttons.connect("left_pressed", left_pressed)
	spookivice.buttons.connect("right_pressed", right_pressed)
#------------------------------------------------------------------------------#
# Custom Signaled Functions
# Power Toggle
func power_toggled(toggled_on: bool) -> void:
	match(toggled_on):
		true: location = Locations.LOCATION
# Main Arrows
func left_pressed(): if [spooki_fsm.states.idle].has(spooki_fsm.state): change_focus("Previous")
func right_pressed(): if [spooki_fsm.states.idle].has(spooki_fsm.state): change_focus("Next")
# Grab Focus
func change_focus(direction: String) -> void:
	var current_focus: Control = get_viewport().gui_get_focus_owner()
	if current_focus && menu_container.is_ancestor_of(current_focus):
		var target_path: NodePath
		match(direction):
			"Previous": target_path = current_focus.focus_previous
			"Next": target_path = current_focus.focus_next
		if !target_path.is_empty():
			var button_to_focus: TextureButton = current_focus.get_node(target_path)
			if button_to_focus:
				button_to_focus.grab_focus()
				spookivice.notifier.add_message(button_to_focus.name, 1, false)
				return
	else:
		spookivice.notifier.add_message(button_feed.name, 1, false)
		button_feed.grab_focus()
#------------------------------------------------------------------------------#
# Custom Functions
func update_location() -> void:
	var old_objects = level.get_node_or_null("Objects")
	if old_objects != null:
		level.remove_child(old_objects)
		old_objects.free()
	if location == "Off": texture = Locations.BACKGROUNDS[location]
	else: texture = Locations.BACKGROUNDS[str("%s_%s" % [location, time])]
	if spookivice != null:
		var level_scene = Locations.OBJECTS["Empty"].instantiate()
		if location != "Off":
			if time != "Day": level_scene = Locations.OBJECTS[location].instantiate()
		level.add_child(level_scene)
		level_scene.name = "Objects"
		spookivice.notifier.add_message("[%s] at [%s]" % [location, time], 2.5, false)
