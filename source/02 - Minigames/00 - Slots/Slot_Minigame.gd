extends TextureRect
#------------------------------------------------------------------------------#
# Variables
var game: String
var top_screen: TextureRect
# OnReady Variables
@onready var slot_button: TextureButton = $SlotButton
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	if game != "": slot_button.texture_normal = Games.GAME_ICONS[game]
#------------------------------------------------------------------------------#
# Signaled Functions
# On Button Focused
func _on_button_focus_entered() -> void:
	top_screen.texture = Games.GAME_PREVIEWS[game]
	top_screen.spookivice.notifier.add_message(
		"[color=853a4c]X[/color] = Back | Play = [color=18372a]O[/color]", 5, false
	)
# On Button Up
func _on_slot_button_up() -> void:
	var game_scene = Games.GAMES[game].instantiate()
	clear_games()
	await get_tree().process_frame
	game_scene.name = game
	Games.add_child(game_scene)
#------------------------------------------------------------------------------#
# Custom Functions
# Clear Active Games
func clear_games() -> void:
	if Games.get_child_count() > 0:
		for game_instance in Games.get_children(): game_instance.queue_free()
