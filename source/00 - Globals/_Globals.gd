extends Node
#------------------------------------------------------------------------------#
# Global Variables
# Cryptid Attibutes
var CONCEPT: String = "Essence"
var CONCEPT_TIME: float = 60
var HAPPINESS: int = 3
var HUNGER: int = 6
var HEALTH: bool = true
var PATH_CHOSEN: bool = false
var PATH: String
var GLIMPSE: String
#------------------------------------------------------------------------------#
# Dissolve
func DISSOLVE(shader: ShaderMaterial, is_appearing: bool, delta: float, speed: float = 1.0) -> bool:
	var current_progress: float = shader.get_shader_parameter("progress")
	# Calculate Direction and Clamp Progress
	var direction: float = -1.0 if is_appearing else 1.0
	var new_progress: float = clamp(current_progress + direction * (speed * delta), 0.0, 1.0)
	shader.set_shader_parameter("progress", new_progress)
	# Check Finished
	var finished_appearing: bool = is_appearing && current_progress > 0.0 && new_progress == 0.0
	var finished_disappearing: bool= !is_appearing && current_progress < 1.0 && new_progress == 1.0
	# Return True When in Boundary
	return finished_appearing || finished_disappearing
