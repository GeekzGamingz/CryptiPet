extends RichTextLabel
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	currency_changed(Shop.CURRENCY)
	Shop.connect("currency_changed", currency_changed)
#------------------------------------------------------------------------------#
# Custom Signaled Functions
# On Currency Changed
func currency_changed(currency): text = str(currency)
