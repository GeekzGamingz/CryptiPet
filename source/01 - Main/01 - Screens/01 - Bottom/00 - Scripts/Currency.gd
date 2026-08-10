extends RichTextLabel
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	Shop.connect("currency_changed", currency_changed)
	currency_changed(Shop.CURRENCY)
#------------------------------------------------------------------------------#
# Custom Signaled Functions
# On Currency Changed
func currency_changed(currency): text = str(currency)
