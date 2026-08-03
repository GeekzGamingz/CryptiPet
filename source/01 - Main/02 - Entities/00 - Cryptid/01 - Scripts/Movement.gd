extends Node2D
## [Cryptid] Movement
##
## This node manages the [Cryptid]'s Movement.
#------------------------------------------------------------------------------#
# Variables
var direction: Vector2 = Vector2.ZERO
var facing: String = "Left"
# Exported Variables
## Sets whether or not the [Cryptid] is flying.
@export var is_flying: bool = false
## Sets the [Cryptid]s base speed.
@export var speed: float = 2.5
# OnReady Variables
@onready var walk_speed: float = speed
@onready var run_speed: float = walk_speed * 2
@onready var max_speed: float = walk_speed
# Local Nodes
@onready var e: CharacterBody2D = $"../.."
@onready var move_timer: Timer = e.get_node("Timers/Movement")
#------------------------------------------------------------------------------#
#Custom Functions
#Movement When Handled By Server 
func handle_movement() -> void:
	if e.ray_north.is_colliding(): direction = Vector2.DOWN
	elif e.ray_east.is_colliding(): direction = Vector2.LEFT
	elif e.ray_south.is_colliding(): direction = Vector2.UP
	elif e.ray_west.is_colliding(): direction = Vector2.RIGHT
	elif move_timer.is_stopped(): move_random()
#Movement
func apply_movement() -> void:
	e.velocity = lerp(e.velocity, direction * max_speed, weight())
	e.move_and_slide()
#Entity Weight
func weight() -> float:
	# Ground Weight
	if !is_flying:
		if direction.is_zero_approx(): return 0.9 # Slow-to-Stop
		elif e.velocity.x != 0 && max_speed == run_speed: return 0.05 # Running
		else: return 0.2 # Walking
	# Air Weight
	return 0.1
#Random Movement
func move_random() -> void:
	randomize()
	var dir_random = (randi() % 15)
	match(dir_random):
		0, 1, 2, 3, 4: direction = Vector2.ZERO
		5, 6, 7: direction = Vector2.RIGHT
		8, 9, 10: direction = Vector2.LEFT
		11: direction = Vector2.UP
		12: direction = Vector2.DOWN
		13: direction = Vector2.ONE
		14: direction = -Vector2.ONE
	move_timer.start()
