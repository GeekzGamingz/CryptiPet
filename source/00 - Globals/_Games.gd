extends Node
#------------------------------------------------------------------------------#
# Global Constants
const SLOT = preload("uid://b7hhdl60lf54g")
#------------------------------------------------------------------------------#
# Global Dictionaries
# Game Scenes
var GAMES: Dictionary = {
	"SnakeEyes": preload("uid://c1yaypmywbw3e"),
	"MothMatch": preload("uid://crj3nao3qfxdp"),
	"FinalWeapon": preload("uid://72qciadle74d")
}
var TITLES: Dictionary = {
	"SnakeEyes": "[wave][color=300004]Snake Eyes[/color][/wave]",
	"MothMatch": "[wave][color=1e392f]Moth Match[/color][/wave]",
	"FinalWeapon": "[wave][color=121236]Final Weapon[/color][/wave]"
}
# Game Icons
var ICONS: Dictionary = {
	"SnakeEyes": preload("uid://ctc1wgqbopvcr"),
	"MothMatch": preload("uid://du83ub8o7krhf"),
	"FinalWeapon": preload("uid://b4x6xai5esxfv")
}
# Game Preivews
var PREVIEWS: Dictionary = {
	"SnakeEyes": preload("uid://buaspksrlmgm1"),
	"MothMatch": preload("uid://xx4nfihqxkws"),
	"FinalWeapon": preload("uid://cyscb00d6opg1")
}
# Game Bottom Screens
var BOTTOMS: Dictionary = {
	"SnakeEyes": preload("uid://cryb4iwfxhine"),
	"MothMatch": preload("uid://4i4jgbjngmcn"),
	"FinalWeapon": preload("uid://dgb4giymtebah")
}
