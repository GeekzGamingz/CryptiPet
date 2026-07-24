extends Control
## Buttons
##
## This node is intended to manage the [TextureButton]s and their functions.
#------------------------------------------------------------------------------#
# Signals
signal left_pressed
signal right_pressed
signal cross_pressed
signal circle_pressed
#------------------------------------------------------------------------------#
# Variables
# OnReady Variables
# Local Nodes
@onready var left: TextureButton = $Left
@onready var right: TextureButton = $Right
@onready var cross: TextureButton = $Cross
@onready var circle: TextureButton = $Circle
#------------------------------------------------------------------------------#
# Signaled Functions
# Left/Right Arrows
func _on_left_button_up() -> void: emit_signal("left_pressed")
func _on_right_button_up() -> void: emit_signal("right_pressed")
# Confirm/Cancel Buttons (X/O; Cross/Circle)
func _on_cross_button_up() -> void: emit_signal("cross_pressed")
func _on_circle_button_up() -> void: emit_signal("circle_pressed")
