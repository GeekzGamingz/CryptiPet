extends Node
#------------------------------------------------------------------------------#
# Global Constants
const OBJECTS = preload("uid://b1a3o0gc63sy4")
const SLOT = preload("uid://dh65x84kel2fh")
#------------------------------------------------------------------------------#
# Global Signals
# Currency Changed
signal currency_changed(new_currency: int)
#------------------------------------------------------------------------------#
# Global Variables
# Currency Tracker
var CURRENCY: int = 10:
	set(new_currency):
		CURRENCY = new_currency
		emit_signal("currency_changed", CURRENCY)
# Globals Dictionaries
# Quantities
var QUANTITIES: Dictionary = {
	# Food
	"Blood": 0, "Book": 0, "Brains": 0, "Energy": 0,
	"Goat": 0, "Leaf": 0, "Meat": 0, "Valuables": 0,
	# Potions
	"Antidote": 0, "Cleanse": 0, "Hate": 0, "Love": 0, "Poison": 0
}
#------------------------------------------------------------------------------#
# Custom Global Functions
# Get Descriptions
func GET_DESCRIPTION(item: String) -> Array:
	var cost: int = 5
	match(item):
		"Brains", "Goat", "Love": cost += 3
		"Book", "Hate", "Cleanse": cost += 2
		"Energy", "Leaf", "Poison", "Antidote": cost -= 2
		"Valuables": cost = 0
		_: pass
	var description: Array = ["Cost: %sv | Owned: %s" % [str(cost), QUANTITIES[item]], cost]
	if item == "Valuables":
		description = ["Cost: - | Owned: %s" % str(CURRENCY), cost]
	return description
