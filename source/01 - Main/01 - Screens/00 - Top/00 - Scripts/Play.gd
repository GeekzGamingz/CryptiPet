extends TextureButton
#------------------------------------------------------------------------------#
# Signals
#------------------------------------------------------------------------------#
# Variables
# OnReady Variables
@onready var top_screen: TextureRect = $"../.."
#------------------------------------------------------------------------------#
# Functions
func _ready() -> void:
	await get_tree().process_frame
	top_screen.spookivice.buttons.connect("circle_pressed", circle_pressed)
#------------------------------------------------------------------------------#
# Signaled Functions
func _on_button_up() -> void: game_select()
#------------------------------------------------------------------------------#
#Activate Game Mode
func game_select(): top_screen.spookivice.outputs.game_select = true
#------------------------------------------------------------------------------#
# Custom Signaled Functions
func circle_pressed(): if has_focus(): emit_signal("button_up")
