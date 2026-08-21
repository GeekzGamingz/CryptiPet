extends Node
#------------------------------------------------------------------------------#
# Globals Constants
#const SLOT = preload("uid://wamq0p3cddv0") ##Make new scene
const NOTEBOOK = preload("uid://fftnyo3s3q8x")
const NOTEBOOK_BOTTOM = preload("uid://bqt6j5srfdf7p")
#------------------------------------------------------------------------------#
# Global Variables
# Global Dictionaries
# Potion Icons
var ICONS: Dictionary = {
	"Antidote": preload("uid://nwcq41qyhuml"),
	"Cleanse": preload("uid://cxo7l37ghs4re"),
	"Hate": preload("uid://ctxne63wyxm51"),
	"Love": preload("uid://dlg1a1dakm2g8"),
	"Poison": preload("uid://dscds0t3n4hre")
}
var ICONS_DISABLED: Dictionary = {
	"Antidote": preload("uid://b3g821yk3e37a"),
	"Cleanse": preload("uid://ccasjoa0ffofo"),
	"Hate": preload("uid://dxk5id14t7w8x"),
	"Love": preload("uid://wa4al8v0coj3"),
	"Poison": preload("uid://bbwqab0tw2s04")
}
# Potion Titles
var TITLES: Dictionary = {
	"Antidote": "[wave][color=3e1c2b]Antidote[/color][/wave]",
	"Cleanse": "[wave][color=3e1c2b]Cleanse[/color][/wave]",
	"Hate": "[wave][color=3e1c2b]Hate[/color][/wave]",
	"Love": "[wave][color=3e1c2b]Love[/color][/wave]",
	"Poison": "[wave][color=3e1c2b]Poison[/color][/wave]",
}
# Potion Descriptions
var DESCRIPTIONS: Dictionary = {
	"Antidote": "",
	"Cleanse": "",
	"Hate": "",
	"Love": "",
	"Poison": "",
}
