extends HBoxContainer
#------------------------------------------------------------------------------#
# Variables
# Bools
var is_dissolving: bool = false
# Exported Variables
@export_enum("1","2","3","4","5","6",) var die1_face: String = "1":
	set(new_face): if die1 != null: die1.frame = int(new_face) - 1
@export_enum("1","2","3","4","5","6",) var die2_face: String = "1":
	set(new_face): if die2 != null: die2.frame = int(new_face) - 1
# OnReady Variables
@onready var die1: Sprite2D = $Container1/Die1
@onready var die2: Sprite2D = $Container2/Die2
@onready var lower: TextureButton = $Container1/Lower
@onready var higher: TextureButton = $Container2/Higher
#------------------------------------------------------------------------------#
# Functions
func _process(delta: float) -> void: if is_dissolving: dissolve(delta)
#------------------------------------------------------------------------------#
# Signaled Functions
func _on_dissolve_timeout() -> void: is_dissolving = true
func _on_lower_button_up() -> void: clear_and_compare("Lower")
func _on_higher_button_up() -> void: clear_and_compare("Higher")
#------------------------------------------------------------------------------#
# Custom Functions
func dissolve(delta: float):
	var die1_shader: ShaderMaterial = die1.material
	var die2_shader: ShaderMaterial = die2.material
	var current_progress = die1_shader.get_shader_parameter("progress")
	die1_shader.set_shader_parameter("progress", current_progress + (1 * delta))
	die2_shader.set_shader_parameter("progress", current_progress + (1 * delta))
	if current_progress >= 1.0:
		die1.hide()
		die2.hide()
		die1_shader.set_shader_parameter("progress", 0)
		die2_shader.set_shader_parameter("progress", 0)
		is_dissolving = false
		lower.grab_focus()
		lower.disabled = false
		higher.disabled = false
# Clear Slot and Compare Results
func clear_and_compare(guess: String):
	lower.disabled = true
	higher.disabled = true
	await Games.get_child(0).compare_results(guess)
	queue_free()
