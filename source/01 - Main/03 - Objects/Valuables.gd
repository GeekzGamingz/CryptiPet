extends TextureButton
#------------------------------------------------------------------------------#
# Variables
# Dictionaries
var textures: Dictionary = {
	"Valuable1": preload("uid://cg1cbxh6rtf85"),
	"Valuable1_Selected": preload("uid://tavfu2kwdc6q"),
	"Valuable1_Mask": preload("uid://bwclgwg6m3qf0"),
	"Valuable2": preload("uid://q53vyhv3tryx"),
	"Valuable2_Selected": preload("uid://qdp3i0xfgwvi"),
	"Valuable2_Mask": preload("uid://lr3nsaqsgr8x"),
	"Valuable3": preload("uid://chqproilmjd87"),
	"Valuable3_Selected": preload("uid://dtj8wm5cwdt5i"),
	"Valuable3_Mask": preload("uid://d0q3vlwc205ic")
}
# Exported Variables
# Enumerations
## Sets the value of the Valuable.
@export var value: int = 1
## Sets the [enum valuables] of the [TextureButton] to the specified [String].
## The [String] is then used as the index for the textures [Dictionary].
@export_enum("Valuable1", "Valuable2", "Valuable3") var valuable = "Valuable1":
	set(new_valuable):
		valuable = new_valuable
		texture_normal = textures[str(new_valuable)]
		texture_hover = textures[str(new_valuable, "_Selected")]
		texture_click_mask = textures[str(new_valuable, "_Mask")]
#------------------------------------------------------------------------------#
# Functions
# Signaled Functions
func _on_button_up() -> void:
	Globals.CURRENCY += value
	queue_free()
