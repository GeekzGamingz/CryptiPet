extends Marker2D
#------------------------------------------------------------------------------#
# Constants
const CRYPTID = preload("uid://dftcgo4cne1st")
#------------------------------------------------------------------------------#
# Signals
signal cryptid_spawned
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
@export var top_screen: TextureRect
#------------------------------------------------------------------------------#
# Functions
func _ready() -> void:
	await get_tree().process_frame
	top_screen.spookivice.toggles.connect("power_toggled", power_toggled)
	top_screen.button_time.connect("switch_time", switch_time)
#------------------------------------------------------------------------------#
# Custom Functions
# Awaken Your Cryptid
func awaken():
	# Remove Other Children & Add New
	if get_child_count() > 0: for child in get_children(): child.free()
	var cryptid_scene = CRYPTID.instantiate()
	add_child(cryptid_scene)
	# Set Cryptid Attributes
	cryptid_scene.concept.stage = Globals.CONCEPT
	cryptid_scene.happiness.stage = Globals.HAPPINESS
	cryptid_scene.hunger.stage = Globals.HUNGER
	cryptid_scene.health.fit = Globals.HEALTH
	cryptid_scene.concept.subtype.path_chosen = Globals.PATH_CHOSEN
	cryptid_scene.concept.subtype.current_path = Globals.PATH
	cryptid_scene.concept.subtype.subtype_glimpse = Globals.GLIMPSE
	cryptid_scene.concept.subtype.update_path()
	# Set Cryptid Location & Timers
	top_screen.location = Locations.LOCATION
	cryptid_scene.concept.morph_timer.wait_time = Globals.CONCEPT_TIME
	cryptid_scene.concept.morph_timer.start()
	top_screen.spookivice.bottom_screen.countdown.morph_timer = cryptid_scene.concept.morph_timer
	# Await & Signal
	await cryptid_scene.sprite_player.animation_finished
	emit_signal("cryptid_spawned", true)
# Allow Your Cryptid to Rest
func sleep():
	if get_child_count() == 0: return
	# Identify Cryptid & Hide
	var cryptid: Cryptid
	for child in get_children(): # Find Only the Cryptid
		if child is Cryptid:
			cryptid = child
			break
	if cryptid == null: return
	cryptid.hiding = true
	# Update Globals
	Globals.CONCEPT = cryptid.concept.stage
	Globals.HAPPINESS = cryptid.happiness.stage
	Globals.HUNGER = cryptid.hunger.stage
	Globals.HEALTH = cryptid.health.fit
	Globals.PATH_CHOSEN = cryptid.concept.subtype.path_chosen
	Globals.PATH = cryptid.concept.subtype.current_path
	Globals.GLIMPSE = cryptid.concept.subtype.subtype_glimpse
	# Check Time Transition
	if !cryptid.concept.time_transitioning:
		if cryptid.concept.morph_timer.time_left > 0.0:
			Globals.CONCEPT_TIME = snappedf(cryptid.concept.morph_timer.time_left, 0.01)
			cryptid.concept.morph_timer.stop()
	else: print("Metamorphosis Detected! Skipping Time Check!")
	# Await Animation, Free, & Signal
	await cryptid.sprite_player.animation_finished
	cryptid.queue_free()
	emit_signal("cryptid_spawned", false)
#------------------------------------------------------------------------------#
# Custom Signaled Functions
# Power Toggle
func power_toggled(toggled_on: bool):
	print("Power Toggled: [%s]" % toggled_on)
	match(toggled_on):
		true: awaken()
		false: sleep()
# Switch Time
func switch_time(new_time: String):
	print("Time Toggled: [%s]" % new_time)
	match(new_time):
		"Day": sleep()
		"Night": awaken()
