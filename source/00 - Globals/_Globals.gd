extends Node
#------------------------------------------------------------------------------#
# Global Signals
# Currency Changed
signal currency_changed
#------------------------------------------------------------------------------#
# Global Variables
var CURRENCY: int = 10:
	set(new_currency):
		CURRENCY = new_currency
		emit_signal("currency_changed", CURRENCY)
# Cryptid Attibutes
var CONCEPT: String = "Essence"
var CONCEPT_TIME: float = 10
var HAPPINESS: String = "Neutral"
var HUNGER: String = "Satiated"
var HEALTH: String = "Fit"
