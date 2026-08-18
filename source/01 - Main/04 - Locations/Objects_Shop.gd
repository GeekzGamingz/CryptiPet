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
# Tree Exited
func _on_tree_exited() -> void:
	var merchant_shader: ShaderMaterial = merchant.material
	merchant_shader.set_shader_parameter("progress", 1)
