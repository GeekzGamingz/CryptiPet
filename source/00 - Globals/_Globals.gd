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
var HAPPINESS: int = 3
var HUNGER: String = "Satiated"
var HEALTH: bool = true
var PATH_CHOSEN: bool = false
var PATH: String
var GLIMPSE: String
