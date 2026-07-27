extends TextureRect
#------------------------------------------------------------------------------#
# Variables
var game: String
var top_screen: TextureRect
# OnReady Variables
@onready var slot_button: TextureButton = $SlotButton
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	if game != "": slot_button.texture_normal = Games.GAME_ICONS[game]
#------------------------------------------------------------------------------#
# Signaled Functions
# On Button Focused
func _on_button_focus_entered() -> void:
	top_screen.texture = Games.GAME_PREVIEWS[game]
	top_screen.spookivice.notifier.add_message(
		"[color=853a4c]X[/color] = Back | Play = [color=18372a]O[/color]", 5, false
	)
