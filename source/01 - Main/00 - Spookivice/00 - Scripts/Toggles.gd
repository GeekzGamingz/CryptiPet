extends Control
## Toggles
##
## This node is intended to manage the toggled [TextureButton]s and their functions.
#------------------------------------------------------------------------------#
# Signals
signal power_toggled
#------------------------------------------------------------------------------#
# Variables
# OnReady Variables
# Local Nodes
@onready var power: TextureButton = $Power
#------------------------------------------------------------------------------#
# Signaled Functions
# Power Toggle
func _on_power_toggled(toggled_on: bool) -> void: emit_signal("power_toggled", toggled_on)
