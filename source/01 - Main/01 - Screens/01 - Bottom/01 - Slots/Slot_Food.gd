extends TextureRect
#------------------------------------------------------------------------------#
# Variables
var item: String
var top_screen: TextureRect
var bottom_screen: TextureRect
# OnReady Variables
@onready var slot_button: TextureButton = $SlotButton
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	if item != "": slot_button.texture_normal = Food.ICONS[item]
#------------------------------------------------------------------------------#
# Signaled Functions
# On Button Focused
func _on_button_focus_entered() -> void:
	top_screen.title.text = Food.TITLES[item]
	top_screen.spookivice.notifier.add_message(
		"[color=853a4c]X[/color] = Back | Feed = [color=18372a]O[/color]", 1, false
	)
	top_screen.info.item.texture = Food.ICONS[item]
	top_screen.info.wrap_text(Food.DESCRIPTIONS[item])
# On Button Up
func _on_slot_button_up() -> void:
	Food.EATEN[item] += 1
	print("[%s] Eaten!" % item)
