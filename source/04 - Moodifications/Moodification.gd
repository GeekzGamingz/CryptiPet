extends MarginContainer
#------------------------------------------------------------------------------#
# Constants
const HAPPY = preload("uid://01wvht4uc4jx")
const HEALTH = preload("uid://c7yl7qh6gry3e")
const HUNGER = preload("uid://dm2gdchbnnort")
#------------------------------------------------------------------------------#
# Variables
# Exported Enumerations
@export_enum("Happiness", "Health", "Hunger") var mood = "":
	set(new_mood):
		mood = new_mood
		switch_texture(new_mood)
# OnReady Variables
@onready var mood_sprite: Sprite2D = $MoodSprite
@onready var free_timer: Timer = $FreeTimer
#------------------------------------------------------------------------------#
# Signaled Functions
func _on_timer_timeout() -> void: queue_free()
#------------------------------------------------------------------------------#
# Custom Functions
func switch_texture(new_mood) -> void:
	match(new_mood):
		"Happiness": mood_sprite.texture = HAPPY
		"Health": mood_sprite.texture = HEALTH
		"Hunger": mood_sprite.texture = HUNGER
	mood_sprite.hframes = floor(mood_sprite.texture.get_width() / 18.0)
