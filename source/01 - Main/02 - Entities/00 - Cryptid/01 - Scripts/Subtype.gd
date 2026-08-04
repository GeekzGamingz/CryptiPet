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
## Called for the Glimpse Stage of the [Cryptid]'s Concept.
func match_glimpse():
	cryptid.sprite_base.texture = Textures.CRYPTIDS[subtype_glimpse]
## Called for the Revealed Stage of the [Cryptid]'s Concept.
func match_revealed():
	if current_path != "": cryptid.sprite_base.texture = Textures.CRYPTIDS[current_path]
## Updates the current_path of the [Cryptid].
func update_path(): set_spirit() # Add Hunger and Health Arguments

func set_undead(): pass

func set_spirit():
	match(happiness.stage):
		var happy when happy >= 5: current_path = "Angel"
		var happy when happy >= 4: current_path = "Grim"
		var happy when happy >= 3: current_path = "Ghost"
		var happy when happy >= 2: current_path = "Shadow"
		_: current_path = "Wraith"
	subtype_glimpse = "Spirit"
	#match(happiness.stage):
		#"Elated", "Euphoric": current_path = "Angel"
		#"Happy": current_path = "Grim"
		#"Neutral": current_path = "Ghost"
		#"Frustrated": current_path = "Shadow"
		#_: current_path = "Wraith"
	#subtype_glimpse = "Spirit"
