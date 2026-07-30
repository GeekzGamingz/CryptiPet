extends Control
#------------------------------------------------------------------------------#
# Variables
# OnReady Variables
@onready var spookivice: Control = get_tree().get_root().get_node("Spookivice")
#------------------------------------------------------------------------------#
# Functions
func _ready() -> void:
	await get_tree().process_frame
	spookivice.notifier.add_message(
		"[color=e92719][pulse]Game Unavailable![/pulse][/color] Press \"[color=e92719]X[/color]\" to Exit.",
		INF,
		false
	)
