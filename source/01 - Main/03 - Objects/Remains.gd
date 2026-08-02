extends TextureButton
#------------------------------------------------------------------------------#
# Variables
# Dictionaries
var textures: Dictionary = {
	"Remains1": preload("uid://dbk23v51e7107"),
	"Remains1_Selected": preload("uid://cr0hsxa7a1wgk"),
	"Remains1_Mask": preload("uid://bhvh7lpsb1ljn"),
	"Remains2": preload("uid://dco8l2j5106mx"),
	"Remains2_Selected": preload("uid://db6rr008ev570"),
	"Remains2_Mask": preload("uid://be0pr7d4aaus7"),
	"Remains3": preload("uid://c8mtsslsu5qjt"),
	"Remains3_Selected": preload("uid://b3m7i5n6u6dmq"),
	"Remains3_Mask": preload("uid://3uiikwvtbysw"),
	"Remains4": preload("uid://df17fop25jef"),
	"Remains4_Selected": preload("uid://cc3tpxogpaag2"),
	"Remains4_Mask": preload("uid://c07q6a8oml50b")
}
# Exported Variables
# Enumerations
## Sets the [enum remains] of the [TextureButton] to the specified [String].
## The [String] is then used as the index for the textures [Dictionary].
@export_enum("Remains1", "Remains2", "Remains3", "Remains4") var remains = "Remains1":
	set(new_remains):
		remains = new_remains
		texture_normal = textures[str(new_remains)]
		texture_hover = textures[str(new_remains, "_Selected")]
		texture_click_mask = textures[str(new_remains, "_Mask")]
#------------------------------------------------------------------------------#
# Functions
# Signaled Functions
func _on_button_up() -> void: queue_free()
func _on_stinky_timeout() -> void: print("Phew! That Stinks!")
