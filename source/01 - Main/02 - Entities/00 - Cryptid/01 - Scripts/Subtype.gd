extends Node2D
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
@export var current_path: String
# Enumerations
## Sets the current subtype for the [Cryptid]'s Glimpse Stage
@export_enum("Spirit", "Undead") var subtype_glimpse: String = "":
	set(new_type): if cryptid != null: subtype_glimpse = new_type
## Sets the current subtype for the [Cryptid]'s Spirit Revealed Stage
@export_enum("Angel", "Ghost", "Grim", "Shadow", "Wraith") var subtype_spirit: String = "":
	set(new_type): if cryptid != null: subtype_spirit = new_type
## Sets the current subtype for the [Cryptid]'s Undead Revealed Stage
@export_enum("Balbal", "Ghoul", "Mummy", "Vampire", "Zombie") var subtype_undead: String = "":
	set(new_type): if cryptid != null: subtype_undead = new_type
# OnReady Variables
# Local Nodes
@onready var cryptid: Cryptid = $"../../.."
@onready var happiness: Node2D = $"../../Happiness"
@onready var hunger: Node2D = $"../../Hunger"
@onready var health: Node2D = $"../../Health"
#------------------------------------------------------------------------------#
# Functions
# Process
func _process(_delta: float) -> void: update_path()
#------------------------------------------------------------------------------#
# Custom Functions
func match_glimpse():
	cryptid.sprite_base.texture = Textures.CRYPTIDS[subtype_glimpse]
func match_path():
	if current_path != "": cryptid.sprite_base.texture = Textures.CRYPTIDS[current_path]
func update_path(): # Add Hunger and Health Arguments
	match(happiness.stage):
		"Elated", "Euphoric": current_path = "Angel"
		"Happy": current_path = "Grim"
		"Neutral": current_path = "Ghost"
		"Frustrated": current_path = "Shadow"
		_: current_path = "Wraith"
	subtype_glimpse = "Spirit"
