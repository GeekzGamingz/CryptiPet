extends TextureRect
#------------------------------------------------------------------------------#
# Variables
var cost: int
var item: String
var top_screen: TextureRect
var bottom_screen: TextureRect
# OnReady Variables
@onready var slot_button: TextureButton = $SlotButton
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	Shop.connect("currency_changed", currency_changed)
	if item != "":
		slot_button.texture_normal = get_autoload().ICONS[item]
		slot_button.texture_disabled = get_autoload().ICONS_DISABLED[item]
	var item_data: Array = Shop.GET_DESCRIPTION(item)
	cost = item_data[1]
	currency_changed(Shop.CURRENCY)
#------------------------------------------------------------------------------#
# Signaled Functions
# On Button Focused
func _on_button_focus_entered() -> void:
	top_screen.spookivice.notifier.add_message(
		"[color=853a4c]X[/color] = Back | Buy = [color=18372a]O[/color]", 1, false
	)
	top_screen.info.item.texture = get_autoload().ICONS[item]
	var item_data: Array = Shop.GET_DESCRIPTION(item)
	top_screen.info.title_shop.text = "[wave]%s[/wave]" % item
	top_screen.info.text_shop.text = item_data[0]
# On Button Up
func _on_slot_button_up() -> void:
	if cost <= Shop.CURRENCY:
		if item != "Valuables":
			Shop.QUANTITIES[item] += 1
			Shop.CURRENCY -= cost
			print("[%s] Purchased!" % item)
		else: print("Valuables Found: Skipping Quantity")
	_on_button_focus_entered()
#------------------------------------------------------------------------------#
# Custom Signaled Functions
# Autoload Helper
func get_autoload() -> Node:
	return (Food as Node) if Food.ICONS.has(item) else (Potions as Node)
# Currency Changed
func currency_changed(currency: int): slot_button.disabled = currency < cost
