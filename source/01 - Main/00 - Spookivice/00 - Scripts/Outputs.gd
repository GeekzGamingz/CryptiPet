extends Node2D
#------------------------------------------------------------------------------#
# Variables
var powered_on: bool = false
var spawned: bool = false
var waiting: bool = false
var food_select: bool = false
var bartering: bool = false
var game_select: bool = false
var game_active: bool = false
# OnReady Variables
@onready var spookivice: Control = $".."
@onready var toggles: Control = $"../Toggles"
@onready var top_screen: TextureRect = $"../Screens/TopScreen"
@onready var orphanage: Marker2D = $"../Screens/TopScreen/Orphanage"
@onready var bottom_screen: TextureRect = $"../Screens/BottomScreen"
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	toggles.connect("power_toggled", power_toggled)
	orphanage.connect("cryptid_spawned", cryptid_spawned)
#------------------------------------------------------------------------------#
# Custom Functions
# Disable Buttons
func disable_buttons(disabled: bool, excluded: Array = []) -> void:
	for button in spookivice.buttons.get_children():
		if !excluded.has(button.name): button.disabled = disabled
	disable_menu(disabled)
# Disable Menu
func disable_menu(disabled: bool, excluded: String = "") -> void:
	for button in top_screen.menu_container.get_children():
		if button.name != excluded: button.disabled = disabled
		if button.has_focus: button.release_focus()
## Enable Choice
#func disable_choice(disabled: bool) -> void:
	#spookivice.buttons.cross.disabled = disabled
	#spookivice.buttons.circle.disabled = disabled
#------------------------------------------------------------------------------#
# Custom Signaled Functions
# Power Toggle
func power_toggled(toggled_on: bool) -> void: powered_on = toggled_on
# Cryptid Spawn Notification
func cryptid_spawned(is_spawned: bool) -> void: spawned = is_spawned
