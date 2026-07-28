extends RichTextLabel
#------------------------------------------------------------------------------#
# Functions
func _process(delta: float) -> void: text = str(Globals.CURRENCY)
