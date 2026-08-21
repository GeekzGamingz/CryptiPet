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
	"Antidote": Potions.ICONS["Antidote"],
	"Cleanse": Potions.ICONS["Cleanse"],
	"Hate": Potions.ICONS["Hate"],
	"Love": Potions.ICONS["Love"],
	"Poison": Potions.ICONS["Poison"]
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
	"Antidote": Potions.ICONS_DISABLED["Antidote"],
	"Cleanse": Potions.ICONS_DISABLED["Cleanse"],
	"Hate": Potions.ICONS_DISABLED["Hate"],
	"Love": Potions.ICONS_DISABLED["Love"],
	"Poison": Potions.ICONS_DISABLED["Poison"]
}
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
