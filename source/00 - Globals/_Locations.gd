extends Node
#------------------------------------------------------------------------------#
## Stores the Current Gloabl Location [String]
var LOCATION: String = "Graveyard"
## Stores the Location Background [Texture2D]s to a Global [Dictionary]
var BACKGROUNDS: Dictionary = {
	"Off": preload("uid://wnc2m06npfqg"),
	"Graveyard_Night": preload("uid://dih5q08gsdjgb"),
	"Graveyard_Day": preload("uid://yl2x2slavk63")
}
## Stores the Bottom Screens [Texture2D]s to a Global [Dictionary].
var BOTTOMS: Dictionary = {
	"Off": preload("uid://c3u4h1h5ya4h8"),
	"On": preload("uid://dm5alueyt0wj8"),
	"Graveyard": preload("uid://cn40pg7yu3ruo")
}
## Store the Location's Scenes and Objects to a Global [Dictionary].
var OBJECTS: Dictionary = {
	"Empty": preload("uid://bw5pywp70qtph"),
	"Graveyard": preload("uid://bpbfwi8r08v7y")
}
