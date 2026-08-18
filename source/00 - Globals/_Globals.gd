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
	var value: float = -1.0 if is_appearing else 1.0
	var new_progress: float = current_progress + value * (speed * delta)
	shader.set_shader_parameter("progress", new_progress)
	return new_progress > 0.0 if is_appearing else new_progress < 1.0
