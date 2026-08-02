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
var BOTTOMS: Dictionary = {
	"Off": preload("uid://c3u4h1h5ya4h8"),
	"On": preload("uid://dm5alueyt0wj8"),
	"Graveyard": preload("uid://cn40pg7yu3ruo")
}
