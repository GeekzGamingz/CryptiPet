extends Node
#------------------------------------------------------------------------------#
## Games
##
## This node is intended to store the [Spookivice] Games for Global useage.
#------------------------------------------------------------------------------#
# Global Constants
const GAME_SLOT = preload("uid://b7hhdl60lf54g")
#------------------------------------------------------------------------------#
# Global Dictionaries
# Game Scenes
var GAMES: Dictionary = {
	"SnakeEyes": preload("uid://c1yaypmywbw3e"),
	"MothMatch": preload("uid://crj3nao3qfxdp")
}
var GAME_TITLE: Dictionary = {
	"SnakeEyes": "[wave][color=300004]Snake Eyes[/color][/wave]",
	"MothMatch": "[wave][color=1e392f]Moth Match[/color][/wave]"
}
# Game Icons
var GAME_ICONS: Dictionary = {
	"SnakeEyes": preload("uid://ctc1wgqbopvcr"),
	"MothMatch": preload("uid://du83ub8o7krhf")
}
# Game Preivews
var GAME_PREVIEWS: Dictionary = {
	"SnakeEyes": preload("uid://buaspksrlmgm1"),
	"MothMatch": preload("uid://xx4nfihqxkws")
}
# Game Bottom Screens
var GAME_BOTTOMS: Dictionary = {
	"SnakeEyes": preload("uid://cryb4iwfxhine"),
	"MothMatch": preload("uid://4i4jgbjngmcn")
}
