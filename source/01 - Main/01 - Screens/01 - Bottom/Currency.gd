extends RichTextLabel
#------------------------------------------------------------------------------#
# Functions
func _process(_delta: float) -> void: text = str(Globals.CURRENCY)
