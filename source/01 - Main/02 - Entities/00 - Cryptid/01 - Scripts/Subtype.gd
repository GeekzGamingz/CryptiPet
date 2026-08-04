extends Node2D
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
@export var current_path: String
# Enumerations
## Sets the current subtype for the [Cryptid]'s Glimpse Stage
@export_enum("Spirit", "Undead") var subtype_glimpse: String = "":
	set(new_type): if cryptid != null:
		subtype_glimpse = new_type
		if subtype_glimpse != "": cryptid.sprite_base.texture = Textures.CRYPTIDS[new_type]
## Sets the current subtype for the [Cryptid]'s Spirit Revealed Stage
@export_enum("Angel", "Ghost", "Grim", "Shadow", "Wraith") var subtype_spirit: String = "":
	set(new_type): if cryptid != null:
		subtype_spirit = new_type
		if subtype_spirit != "": cryptid.sprite_base.texture = Textures.CRYPTIDS[new_type]
## Sets the current subtype for the [Cryptid]'s Undead Revealed Stage
@export_enum("Balbal", "Ghoul", "Mummy", "Vampire", "Zombie") var subtype_undead: String = "":
	set(new_type): if cryptid != null:
		subtype_undead = new_type
		if subtype_undead != "": cryptid.sprite_base.texture = Textures.CRYPTIDS[new_type]
# OnReady Variables
# Local Nodes
@onready var cryptid: Cryptid = $"../../.."
@onready var happiness: Node2D = $"../../Happiness"
@onready var hunger: Node2D = $"../../Hunger"
@onready var health: Node2D = $"../../Health"
#------------------------------------------------------------------------------#
func find_path():
	print("Got Here")
