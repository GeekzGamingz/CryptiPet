extends TextureButton
#------------------------------------------------------------------------------#
# Signals
signal switch_time
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
func _on_toggled(toggled_on: bool) -> void:
	top_screen.time = "Day" if toggled_on else "Night"
	match(top_screen.time):
		"Day": emit_signal("switch_time", "Day")
		"Night": emit_signal("switch_time", "Night")
#------------------------------------------------------------------------------#
# Custom Signaled Functions
func circle_pressed():
	if has_focus(): button_pressed = !button_pressed
