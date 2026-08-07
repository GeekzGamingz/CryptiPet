extends Node2D
#------------------------------------------------------------------------------#
# Variables
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
# Functions
# Process
#func _process(_delta: float) -> void: update_path()
#------------------------------------------------------------------------------#
# Custom Functions
## Called for the Glimpse Stage of the [Cryptid]'s Concept.
func match_glimpse():
	cryptid.sprite_base.texture = Textures.CRYPTIDS[subtype_glimpse]
## Called for the Revealed Stage of the [Cryptid]'s Concept.
func match_revealed():
	if current_path != "": cryptid.sprite_base.texture = Textures.CRYPTIDS[current_path]
## Updates the current_path of the [Cryptid].
func update_path(): 
	# Check Consumed Food
	var consumed: Array = []
	for food in Food.EATEN:
		if Food.EATEN[food] > 0:
			consumed.append(food)
	# Compare to Cryptid Diets
	var possible_cryptids: Array = []
	for cryptid_index in Food.DIETS:
		var diet = Food.DIETS[cryptid_index]
		var restrictions = Food.RESTRICTED[cryptid_index]
		# If Nothing Was Eaten, Skip Cryptids That Don't Need Food
		if consumed.is_empty() && !diet.has("All"): continue
		# Check Diet
		var can_eat: bool = true
		if diet.has("All"): possible_cryptids.append(cryptid_index)
		for food in consumed:
			if restrictions.has(food) || !diet.has(food):
				can_eat = false
				break
		if can_eat: match(cryptid_index):
			# Spirits
			"Angel": if happiness.stage >= 5 && health.fit: possible_cryptids.append(cryptid_index)
			"Ghost": if happiness.stage >= 3: possible_cryptids.append(cryptid_index)
			"Grim": if happiness.stage >= 4 && health.fit: possible_cryptids.append(cryptid_index)
			"Mothman_Spirit": if happiness.stage >= 4: possible_cryptids.append(cryptid_index)
			"Shadow": if happiness.stage >= 2: possible_cryptids.append(cryptid_index)
			# Undead
			"Ghoul": if happiness.stage <= 3: possible_cryptids.append(cryptid_index)
			"Mothman_Undead": if happiness.stage >= 4 && !health.fit: possible_cryptids.append(cryptid_index)
			"Mummy": if happiness.stage >= 4 && health.fit: possible_cryptids.append(cryptid_index)
			"Vampire": if happiness.stage >= 4: possible_cryptids.append(cryptid_index)
			"Zombie": if !health.fit: possible_cryptids.append(cryptid_index)
	# Only Allow Wraiths and Balbals When No Path Found
	if possible_cryptids.size() >= 3:
		if possible_cryptids.has("Wraith"): possible_cryptids.erase("Wraith")
		if possible_cryptids.has("Balbal"): possible_cryptids.erase("Balbal")
	print("Consumed: ", consumed)
	print("Possible Cryptids: ", possible_cryptids)
	# Pick Path
	current_path = possible_cryptids.pick_random()
	match(current_path):
		"Angel", "Ghost", "Grim", "Mothman_Spirit", "Shadow", "Wraith": subtype_glimpse = "Spirit"
		"Balbal", "Ghoul", "Mothman_Undead", "Mummy", "Vampire", "Zombie": subtype_glimpse = "Undead"
	print("Chosen Path: %s [%s]" % [current_path, subtype_glimpse])
	
