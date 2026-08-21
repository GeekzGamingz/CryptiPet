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
	"Antidote": preload("uid://nwcq41qyhuml"),
	"Cleanse": preload("uid://cxo7l37ghs4re"),
	"Hate": preload("uid://ctxne63wyxm51"),
	"Love": preload("uid://dlg1a1dakm2g8"),
	"Poison": preload("uid://dscds0t3n4hre")
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
	"Antidote": preload("uid://b3g821yk3e37a"),
	"Cleanse": preload("uid://ccasjoa0ffofo"),
	"Hate": preload("uid://dxk5id14t7w8x"),
	"Love": preload("uid://wa4al8v0coj3"),
	"Poison": preload("uid://bbwqab0tw2s04")
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
