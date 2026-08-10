extends Node2D
#------------------------------------------------------------------------------#
# Variables
var path_chosen: bool = false
# Exported Variables
@export var current_path: String
# Enumerations
## Sets the current subtype for the [Cryptid]'s Glimpse Stage
@export_enum("Spirit", "Undead") var subtype_glimpse: String = "":
	set(new_type): if cryptid != null: subtype_glimpse = new_type
# OnReady Variables
# Local Nodes
@onready var cryptid: Cryptid = $"../../.."
@onready var happiness: Node2D = $"../../Happiness"
@onready var hunger: Node2D = $"../../Hunger"
@onready var health: Node2D = $"../../Health"
#------------------------------------------------------------------------------#
# Custom Functions
## Called for the Glimpse Stage of the [Cryptid]'s Concept.
func match_glimpse():
	cryptid.sprite_base.texture = Textures.CRYPTIDS[subtype_glimpse]
## Called for the Revealed Stage of the [Cryptid]'s Concept.
func match_revealed():
	if current_path != "": cryptid.sprite_base.texture = Textures.CRYPTIDS[current_path]
## Updates the current_path of the [Cryptid].
func update_path(): if !path_chosen:
	# Check Consumed Food
	var consumed: Array = []
	for food in Food.EATEN:
		if Food.EATEN[food] > 0:
			consumed.append(food)
	# Compare to Cryptid Diets
	var possible_cryptids: Array = []
	var path_found: bool = false
	for cryptid_index in Food.DIETS:
		var diet = Food.DIETS[cryptid_index]
		var restrictions = Food.RESTRICTED[cryptid_index]
		var iron_gut: bool = diet.has("All")
		# If Nothing Was Eaten, Skip Cryptids That Don't Need Food
		if consumed.is_empty() && !iron_gut: continue
		# Check Diet
		var can_eat: bool = true
		for food in consumed:
			if restrictions.has(food) || !diet.has(food):
				can_eat = false
				break
		if !can_eat: continue
		# Check Requirements
		var requirements_met: bool = false
		match(cryptid_index):
			# Spirits
			"Angel": requirements_met = happiness.stage >= 5 && health.fit
			"Ghost": requirements_met = happiness.stage >= 3
			"Grim": requirements_met = happiness.stage >= 4 && health.fit
			"Mothman_Spirit": requirements_met = happiness.stage >= 4
			"Shadow": requirements_met = happiness.stage >= 2
			# Undead
			"Ghoul": requirements_met = happiness.stage <= 3
			"Mothman_Undead": requirements_met = happiness.stage >= 4 && !health.fit
			"Mummy": requirements_met = happiness.stage >= 4 && health.fit
			"Vampire": requirements_met = happiness.stage >= 4
			"Zombie": requirements_met = !health.fit
			# Catch-All
			_: requirements_met = false
		if requirements_met:
			possible_cryptids.append(cryptid_index)
			path_found = true
	# Only Allow Wraiths and Balbals When No Path Found
	if !path_found:
		possible_cryptids.append("Wraith")
		possible_cryptids.append("Balbal")
	print("Consumed: ", consumed)
	print("Possible Cryptids: ", possible_cryptids)
	# Failsafe
	if possible_cryptids.is_empty():
		printerr("No Evolution Paths Found!")
		return
	# Select Path
	current_path = possible_cryptids.pick_random()
	match(current_path):
		"Angel", "Ghost", "Grim", "Mothman_Spirit", "Shadow", "Wraith": subtype_glimpse = "Spirit"
		"Balbal", "Ghoul", "Mothman_Undead", "Mummy", "Vampire", "Zombie": subtype_glimpse = "Undead"
	print("Chosen Path: %s [%s]" % [current_path, subtype_glimpse])
	
