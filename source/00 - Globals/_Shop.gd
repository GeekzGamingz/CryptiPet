extends Node
#------------------------------------------------------------------------------#
# Global Constants
const OBJECTS = preload("uid://b1a3o0gc63sy4")
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
