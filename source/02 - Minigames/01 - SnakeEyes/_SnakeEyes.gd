extends Control
## Snake Eyes
##
## This manages the dice game, Snake Eyes.
#------------------------------------------------------------------------------#
# Constants
const _ROLL = preload("uid://dtnrkc8mjslnf")
const _TONGUE = preload("uid://jw0r8unm4xvm")
const _BITE = preload("uid://dwkd1vw3nj5v6")
const SLOT_DICE = preload("uid://6i70xf67afgl")
#------------------------------------------------------------------------------#
# Variables
# Bools
var bet_decrease: bool = false
var bet_increase: bool = false
var doubles: bool = false
# Integers
var current_bet: int = 0
var last_result: int
# Exported Variables
## References the Amount [RichTextLabel] Node.
@export var amount_label: RichTextLabel
# OnReady Variables
@onready var spookivice: Control = get_tree().get_root().get_node("Spookivice")
@onready var increment_timer: Timer = $Increment
@onready var random = RandomNumberGenerator.new()
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	update_bet()
	spookivice.buttons.connect("minus_pressed", alter_bet.bind("Decrease", true))
	spookivice.buttons.connect("minus_released", alter_bet.bind("Decrease", false))
	spookivice.buttons.connect("plus_pressed", alter_bet.bind("Increase", true))
	spookivice.buttons.connect("plus_released", alter_bet.bind("Increase", false))
	Globals.currency_changed.connect(func(_amount): update_bet())
	last_result = await roll_dice()
	show_result(last_result)
#------------------------------------------------------------------------------#
# Signaled Functions
func _on_increment_timeout() -> void:
	if bet_increase:
		if current_bet < Globals.CURRENCY && current_bet < 999: current_bet += 1
	elif bet_decrease && current_bet > 0: current_bet -= 1
	update_bet()
#------------------------------------------------------------------------------#
# Custom Functions
# Roll Dice
func roll_dice() -> int:
	# Notification
	spookivice.notifier.add_message("Rolling Your Fate!", 2.5, false)
	# Animate Screen
	spookivice.top_screen.texture = _ROLL
	spookivice.top_screen.texture.current_frame = 0
	spookivice.top_screen.texture.pause = false
	# Create/Roll Dice
	random.randomize()
	var die1 = random.randi_range(1, 6)
	var die2 = random.randi_range(1, 6)
	var total = die1 + die2
	doubles = true if die1 == die2 else false
	print("Die 1: ", die1)
	print("Die 2: ", die2)
	if doubles: print("[DOUBLES!!]")
	print("Dice Total: ", total)
	# Await and Instantiate, But Keep Hidden
	await get_tree().process_frame
	var dice_scene = SLOT_DICE.instantiate()
	spookivice.bottom_screen.scroll_container.show()
	spookivice.bottom_screen.slot_container.add_child(dice_scene)
	dice_scene.hide()
	# Await and Show Results
	await get_tree().create_timer(2.1).timeout
	if doubles: spookivice.notifier.add_message(
		"[rainbow][wave]DOUBLES[/wave][/rainbow]! Next Payout is [u]Doubled[/u]!!",
		2.5, false
	)
	dice_scene.show()
	dice_scene.die1_face = str(die1)
	dice_scene.die2_face = str(die2)
	# Return the Total Dice Roll
	return total
# Show Results
func show_result(result) -> void:
	var message: String
	match(result):
		2, 12: message = "Result: [rainbow][pulse][%s][/pulse][/rainbow]" % result
		3, 4, 10, 11: message = "Result: [color=eddc3c][pulse][%s][/pulse][/color]" % result
		_: message = "Result: [%s]" % result
	spookivice.top_screen.title.text = message
# Compare Results
func compare_results(guess: String) -> void:
	var new_result: int = await roll_dice()
	var comparison: String
	if new_result > last_result: comparison = "Higher"
	elif new_result < last_result: comparison = "Lower"
	else: comparison = "Match"
	match(comparison):
		"Match": show_outcome(comparison)
		guess: show_outcome("Win")
		_: show_outcome("Loss")
	last_result = new_result
	show_result(last_result)
# Outcome
func show_outcome(outcome):
	var outcome_string: String
	var wait_time: float = 0.9
	match(outcome):
		"Win":
			spookivice.top_screen.texture = _TONGUE
			if doubles: Globals.CURRENCY += current_bet * 2
			else: Globals.CURRENCY += current_bet
			outcome_string = "[rainbow][wave]You Won![/wave][/rainbow]"
		"Match":
			spookivice.top_screen.texture = _TONGUE
			if doubles: Globals.CURRENCY += current_bet
			else: Globals.CURRENCY += floor(current_bet * 0.5)
			outcome_string = "[color=458f58][pulse]You Matched![/pulse][/color]"
		"Loss":
			spookivice.top_screen.texture = _BITE
			Globals.CURRENCY -= current_bet
			if Globals.CURRENCY <= 0: Globals.CURRENCY = 0
			outcome_string = "[color=e92719][pulse]You Lost![/pulse][/color]"
			wait_time = 1.7
	spookivice.top_screen.texture.current_frame = 0
	spookivice.top_screen.texture.pause = false
	await get_tree().create_timer(wait_time).timeout
	spookivice.notifier.add_message(
		"[%s]! Try Your Luck Again?" % outcome_string, INF, false
	)
# Update Bet Display
func update_bet() -> void:
	amount_label.text = str(current_bet, "/", Globals.CURRENCY)
	current_bet = 0
#------------------------------------------------------------------------------#
# Custom Signaled Functions
func alter_bet(increment, is_pressed) -> void:
	match(increment):
		"Decrease":
			bet_decrease = is_pressed
			if current_bet < Globals.CURRENCY && current_bet > 0:
				current_bet -= 1 if !is_pressed else 0
		"Increase":
			bet_increase = is_pressed
			if current_bet < Globals.CURRENCY && current_bet < 999:
				current_bet += 1 if !is_pressed else 0
	match(is_pressed):
		true: increment_timer.start()
		false: increment_timer.stop()
	update_bet()
