extends Node2D
## Snake Eyes
##
## This manages the dice game, Snake Eyes.
#------------------------------------------------------------------------------#
#Variables
#------------------------------------------------------------------------------#
#Functions
#Ready
func _ready() -> void: print("Returned Value: ", roll_dice())
#------------------------------------------------------------------------------#
#Custom Functions
#Roll Dice
func roll_dice() -> int:
	var random = RandomNumberGenerator.new()
	random.randomize()
	var die1 = random.randi_range(1, 6)
	var die2 = random.randi_range(1, 6)
	var total = die1 + die2
	var doubles = true if die1 == die2 else false
	print("Die 1: ", die1)
	print("Die 2: ", die2)
	if doubles: print("[DOUBLES!!]")
	print("Dice Total: ", total)
	return total
