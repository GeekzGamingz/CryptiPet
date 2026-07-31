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
			print("New Currency: ", new_currency)
var LOCATION: String = "Graveyard"
# Cryptid Attibutes
var CONCEPT: String = "Essence"
var CONCEPT_TIME: float = 60
