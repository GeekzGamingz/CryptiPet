extends Control
#------------------------------------------------------------------------------#
# Constants
const MOODIFICATION = preload("uid://rfx52shse0d1")
#------------------------------------------------------------------------------#
# Variables
# OnReady Variables
@onready var moodifications: VBoxContainer = $Moodifications
#------------------------------------------------------------------------------#
# Custom Functions
# Add Mood
func add_mood(mood, stage, timeout):
	for moodification in moodifications.get_children():
		if moodification.mood == mood: moodification.queue_free()
	var mood_scene = MOODIFICATION.instantiate()
	moodifications.add_child(mood_scene)
	mood_scene.mood = mood
	mood_scene.mood_sprite.frame = stage
	mood_scene.free_timer.wait_time = timeout
	mood_scene.free_timer.start()
# Clear Moods
func clear_moods():
	for mood in moodifications: mood.queue_free()
