extends TextureRect
#------------------------------------------------------------------------------#
# Variables
var food: String
var top_screen: TextureRect
var bottom_screen: TextureRect
# OnReady Variables
@onready var slot_button: TextureButton = $SlotButton
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	if food != "": slot_button.texture_normal = Food.ICONS[food]
#------------------------------------------------------------------------------#
# Signaled Functions
# On Button Focused
func _on_button_focus_entered() -> void:
	top_screen.title.text = Food.TITLES[food]
	top_screen.spookivice.notifier.add_message(
		"[color=853a4c]X[/color] = Back | Feed = [color=18372a]O[/color]", 1, false
	)
	top_screen.info.item.texture = Food.ICONS[food]
	top_screen.info.wrap_text(Food.DESCRIPTIONS[food])
# On Button Up
func _on_slot_button_up() -> void:
	Food.EATEN[food] += 1
	print("[%s] Eaten!" % food)
##------------------------------------------------------------------------------#
## Custom Functions
## Clear Active Games
#func clear_games() -> void:
	#if Games.get_child_count() > 0:
		#for game_instance in Games.get_children(): game_instance.queue_free()
## Clear Buttons
#func clear_buttons() -> void:
	#var siblings = get_parent().get_children()
	#for button in siblings: button.queue_free()
