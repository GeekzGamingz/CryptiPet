extends Node
#------------------------------------------------------------------------------#
## Stores the Current Gloabl Location [String]
var LOCATION: String = "Graveyard"
## Stores the Location Background [Texture2D]s to a Global [Dictionary]
var BACKGROUNDS: Dictionary = {
	"Off": preload("uid://wnc2m06npfqg"),
	"Graveyard_Night": preload("uid://dtd5fcqyd17to"),
	"Graveyard_Day": preload("uid://5y0xykj2iki7")
}
