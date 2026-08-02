extends Node
## Textures
##
## This node is intended to store the [Texture2D]s for Global useage.
#------------------------------------------------------------------------------#
# Global Variables
# Global Dictionaries
## Stores the Spookivice [Texture2D]s to a Global [Dictionary]
var DEVICE: Dictionary = {
	"STANDBY": preload("uid://4250jyv0a3f7"),
	"ALERT": preload("uid://d4k1sw56dkn5x")
}
## Stores the Cryptid Sprite Sheet [Texture2D]s to a Global [Dictionary]
var CRYPTIDS: Dictionary = {
	"Essence": preload("uid://iwxc6pn28n3e"), # All Essences
	"Rumor": preload("uid://dhn12h3asjb3v"), # All Rumors
	# Glimpse Branch
	"Spirit": preload("uid://2tw4ybvhrgv7"),
	"Undead": preload("uid://oy7dvl547x2n"),
	# Revealed Branch
	# Undead
	"Balbal": preload("uid://bvkvnf1fsrh6"),
	"Ghoul": preload("uid://buwemwaguepmm"),
	"Mothman_Undead": preload("uid://bx08ihjayt0nl"),
	"Mummy": preload("uid://de4bgy8o25js8"),
	"Vampire": preload("uid://cjbldg7iq8tt3"),
	"Zombie": preload("uid://bxio7xjsgpmte"),
	# Spirit
	"Angel": preload("uid://utdjmws14eqe"),
	"Ghost": preload("uid://60vgglmh06sd"),
	"Grim": preload("uid://dpjgdcnvk7876"),
	"Mothman_Spirit": preload("uid://b2gwv2or74usf"),
	"Shadow": preload("uid://bgkg6gqm60e5t"),
	"Wraith": preload("uid://chptpbusmap0c")
}
