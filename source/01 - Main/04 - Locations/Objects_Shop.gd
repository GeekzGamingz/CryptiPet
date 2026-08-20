extends Node2D
#------------------------------------------------------------------------------#
# Variables
var is_dissolving: bool = false
# OnReady Variables
@onready var merchant: Sprite2D = $Merchant/Merchant
#------------------------------------------------------------------------------#
# Functions
# Process
func _process(delta: float) -> void:
	if is_dissolving: Globals.DISSOLVE(merchant.material, true, delta)
#------------------------------------------------------------------------------#
# Signaled Functions
# Appearance Timeout
func _on_appearance_timeout() -> void: is_dissolving = true
