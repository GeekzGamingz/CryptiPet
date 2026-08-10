extends Node2D
#------------------------------------------------------------------------------#
# Variables
var is_dissolving: bool = false
# OnReady Variables
@onready var merchant: Sprite2D = $Merchant/Merchant
#------------------------------------------------------------------------------#
# Functions
# Process
func _process(delta: float) -> void: if is_dissolving: dissolve(delta, true)
#------------------------------------------------------------------------------#
# Signaled Functions
# Appearance Timeout
func _on_appearance_timeout() -> void: is_dissolving = true
# Tree Exited
func _on_tree_exited() -> void:
	var merchant_shader: ShaderMaterial = merchant.material
	merchant_shader.set_shader_parameter("progress", 1)
#------------------------------------------------------------------------------#
# Custom Functions
# Dissolve
func dissolve(delta: float, is_appearing):
	var merchant_shader: ShaderMaterial = merchant.material
	var current_progress = merchant_shader.get_shader_parameter("progress")
	var condition
	if is_appearing:
		condition = (current_progress <= 0)
		merchant_shader.set_shader_parameter("progress", current_progress - (1 * delta))
	else: # Progress @ 1.0 is Completely Dissolved
		condition = (current_progress >= 1)
		merchant_shader.set_shader_parameter("progress", current_progress + (1 * delta))
	if condition:
		is_dissolving = false
