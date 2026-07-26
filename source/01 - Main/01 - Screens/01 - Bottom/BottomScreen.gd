extends TextureRect
#------------------------------------------------------------------------------#
const _BOTTOM_OFF = preload("uid://c3u4h1h5ya4h8")
const _BOTTOM_ON = preload("uid://dm5alueyt0wj8")
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
## Sets the Bottom Screen's [enum phase].
@export_enum("On", "Off") var phase = "Off":
	set(new_phase):
		phase = new_phase
		update_screen()
## References the Menu Container [HBoxContainer]
@export var menu_container: HBoxContainer
## References the Countdown [PanelContainer]
@export var countdown_container: MarginContainer
## References the Countdown [RichTextLabel]
@export var countdown: RichTextLabel
# OnReady Variables
# Main Nodes
@onready var spookivice: Control = get_tree().get_root().get_node("Spookivice")
#------------------------------------------------------------------------------#
# Ready
func _ready() -> void:
	await get_tree().process_frame
	spookivice.fsm.connect("start_game_mode", spawn_games)
#------------------------------------------------------------------------------#
# Custom Functions
func update_screen():
	match(phase):
		"On":
			texture = _BOTTOM_ON
			$TabContainer.set_deferred("visible", true)
		"Off":
			texture = _BOTTOM_OFF
			$TabContainer.set_deferred("visible", false)
#------------------------------------------------------------------------------#
# Custom Signaled Functions
func spawn_games(to_spawn: bool) -> void:
	match(to_spawn):
		true: print("Spawn Games: [%s]" % to_spawn)
		false: print("Delete Games: [%s]" % !to_spawn)
