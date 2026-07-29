extends Control
## Snake Eyes
##
## This manages the dice game, Snake Eyes.
#------------------------------------------------------------------------------#
# Constants
const _BITE = preload("uid://jw0r8unm4xvm")
const _ROLL = preload("uid://dtnrkc8mjslnf")
const SLOT_DICE = preload("uid://6i70xf67afgl")
#------------------------------------------------------------------------------#
# Variables
# Bools
var bet_descrease: bool = false
var bet_increase: bool = false
# Integers
var current_bet: int = 0
# Exported Variables
## References the Amount [RichTextLabel] Node.
@export var amount_label: RichTextLabel
# OnReady Variables
@onready var spookivice: Control = get_tree().get_root().get_node("Spookivice")
@onready var increment_timer: Timer = $Increment
#------------------------------------------------------------------------------#
# Functions
# Process
func _process(_delta: float) -> void: amount_label.text = str(current_bet)
# Ready
func _ready() -> void:
	spookivice.buttons.connect("minus_pressed", alter_bet.bind("Decrease", true))
	spookivice.buttons.connect("minus_released", alter_bet.bind("Decrease", false))
	spookivice.buttons.connect("plus_pressed", alter_bet.bind("Increase", true))
	spookivice.buttons.connect("plus_released", alter_bet.bind("Increase", false))
	print("Returned Value: ", await roll_dice())
#------------------------------------------------------------------------------#
# Signaled Functions
func _on_increment_timeout() -> void:
	if bet_increase:
		if current_bet < Globals.CURRENCY && current_bet < 999: current_bet += 1
	elif bet_descrease && current_bet > 0: current_bet -= 1
	amount_label.text = str(current_bet)
#------------------------------------------------------------------------------#
# Custom Functions
# Roll Dice
func roll_dice() -> int:
	spookivice.notifier.add_message("Rolling Your Fate!", 2.5, false)
	spookivice.top_screen.texture = _ROLL
	spookivice.top_screen.texture.current_frame = 0
	spookivice.top_screen.texture.pause = false
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
	await get_tree().process_frame
	var dice_scene = SLOT_DICE.instantiate()
	spookivice.bottom_screen.scroll_container.show()
	spookivice.bottom_screen.slot_container.add_child(dice_scene)
	dice_scene.hide()
	await get_tree().create_timer(2.1).timeout
	if doubles: spookivice.notifier.add_message("DOUBLES! Next Payout is Doubled!!", 2.5, false)
	dice_scene.show()
	dice_scene.die1_face = str(die1)
	dice_scene.die2_face = str(die2)
	return total
#------------------------------------------------------------------------------#
# Custom Signaled Functions
func alter_bet(increment, is_pressed):
	match(increment):
		"Decrease":
			bet_descrease = is_pressed
			if current_bet < Globals.CURRENCY && current_bet > 0:
				current_bet -= 1 if !is_pressed else 0
		"Increase":
			bet_increase = is_pressed
			if current_bet < Globals.CURRENCY && current_bet < 999:
				current_bet += 1 if !is_pressed else 0
	match(is_pressed):
		true: increment_timer.start()
		false: increment_timer.stop()
