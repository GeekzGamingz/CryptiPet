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
signal minus_pressed
signal minus_released
signal plus_pressed
signal plus_released
#------------------------------------------------------------------------------#
# Variables
# OnReady Variables
# Local Nodes
@onready var left: TextureButton = $Left
@onready var right: TextureButton = $Right
@onready var cross: TextureButton = $Cross
@onready var circle: TextureButton = $Circle
@onready var minus: TextureButton = $Minus
@onready var plus: TextureButton = $Plus
#------------------------------------------------------------------------------#
# Signaled Functions
# Left/Right Arrows
func _on_left_button_up() -> void: emit_signal("left_pressed")
func _on_right_button_up() -> void: emit_signal("right_pressed")
# Cancel/Confirm Buttons (X/O; Cross/Circle)
func _on_cross_button_up() -> void: emit_signal("cross_pressed")
func _on_circle_button_up() -> void: emit_signal("circle_pressed")
# Decrease/Increase Button (-/+; Minus/Plus)
# Tracking Both Up/Down for Holding Perameters
func _on_minus_button_down() -> void: emit_signal("minus_pressed")
func _on_minus_button_up() -> void: emit_signal("minus_released")
func _on_plus_button_down() -> void: emit_signal("plus_pressed")
func _on_plus_button_up() -> void: emit_signal("plus_released")
