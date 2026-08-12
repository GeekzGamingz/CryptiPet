extends Node
#------------------------------------------------------------------------------#
# Global Constants
const OBJECTS = preload("uid://b1a3o0gc63sy4")
const SLOT = preload("uid://dh65x84kel2fh")
#------------------------------------------------------------------------------#
# Global Signals
# Currency Changed
signal currency_changed
#------------------------------------------------------------------------------#
# Global Variables
# Currency Tracker
var CURRENCY: int = 10:
	set(new_currency):
		CURRENCY = new_currency
		emit_signal("currency_changed", CURRENCY)
# Globals Dictionaries
# Icons
var ICONS: Dictionary = {
	# Food
	"Blood": Food.ICONS["Blood"],
	"Book": Food.ICONS["Book"],
	"Brains": Food.ICONS["Brains"],
	"Energy": Food.ICONS["Energy"],
	"Goat": Food.ICONS["Goat"],
	"Leaf": Food.ICONS["Leaf"],
	"Meat": Food.ICONS["Meat"],
	"Valuables": Food.ICONS["Valuables"],
	# Potions
}
var ICONS_DISABLED: Dictionary = {
	# Food
	"Blood": Food.ICONS_DISABLED["Blood"],
	"Book": Food.ICONS_DISABLED["Book"],
	"Brains": Food.ICONS_DISABLED["Brains"],
	"Energy": Food.ICONS_DISABLED["Energy"],
	"Goat": Food.ICONS_DISABLED["Goat"],
	"Leaf": Food.ICONS_DISABLED["Leaf"],
	"Meat": Food.ICONS_DISABLED["Meat"],
	"Valuables": Food.ICONS_DISABLED["Valuables"],
	# Potions
}
# Quantities
var QUANTITIES: Dictionary = {
	"Blood": 0, "Book": 0, "Brains": 0, "Energy": 0,
	"Goat": 0, "Leaf": 0, "Meat": 0, "Valuables": 0
}
#------------------------------------------------------------------------------#
# Custom Global Functions
# Get Descriptions
func GET_DESCRIPTION(item: String) -> Array:
	var cost: int = 5
	match(item):
		"Book": cost += 2
		"Brains", "Goat": cost += 3
		"Energy", "Leaf": cost -= 2
		"Valuables": cost = 0
		_: pass
	var description: Array = ["Cost: %sv | Owned: %s" % [str(cost), QUANTITIES[item]], cost]
	if item == "Valuables":
		description = ["Cost: - | Owned: %s" % str(CURRENCY), cost]
	return description
