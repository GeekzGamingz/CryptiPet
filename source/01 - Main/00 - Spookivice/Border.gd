extends Polygon2D
## Border
##
## This node is intended to store the [Polygon2D] variables for when switching the window's clickable mask.
#------------------------------------------------------------------------------#
# Variables
# Stored Polygons
# Sample Polygon
## @deprecated: This is a sample [PackedVector2Array] for debugging purposes only.
var polygon1: PackedVector2Array = PackedVector2Array([
	Vector2(91.0, 56.0), Vector2(191.0, 56.0), Vector2(198.0, 59.0), Vector2(243.0, 104.0), Vector2(246.0, 111.0),
	Vector2(246.0, 125.0), Vector2(250.0, 129.0), Vector2(252.0, 140.0), Vector2(252.0, 182.0), Vector2(250.0, 193.0),
	Vector2(246.0, 197.0), Vector2(246.0, 211.0), Vector2(243.0, 218.0), Vector2(198.0, 263.0), Vector2(191.0, 266.0),
	Vector2(91.0, 266.0), Vector2(84.0, 263.0), Vector2(39.0, 218.0), Vector2(36.0, 211.0), Vector2(36.0, 197.0),
	Vector2(32.0, 193.0), Vector2(30.0, 182.0), Vector2(30.0, 140.0), Vector2(32.0, 129.0), Vector2(36.0, 125.0),
	Vector2(36.0, 111.0), Vector2(39.0, 104.0), Vector2(84.0, 59.0)])
# Base Polygon
## This is the default [PackedVector2Array] that is used for the [Polygon2D] if nothing is set or set incorrectly.
var base_border: PackedVector2Array = PackedVector2Array([
	Vector2(90.0, 55.0), Vector2(97.0, 55.0), Vector2(100.0, 52.0), Vector2(101.0, 52.0), Vector2(101.0, 40.0),
	Vector2(99.0, 38.0), Vector2(99.0, 34.0), Vector2(104.0, 29.0), Vector2(107.0, 29.0), Vector2(112.0, 34.0),
	Vector2(112.0, 38.0), Vector2(110.0, 40.0), Vector2(110.0, 52.0), Vector2(111.0, 52.0), Vector2(114.0, 55.0),
	Vector2(167.0, 55.0), Vector2(170.0, 52.0), Vector2(171.0, 52.0), Vector2(171.0, 40.0), Vector2(169.0, 38.0),
	Vector2(169.0, 34.0), Vector2(174.0, 29.0), Vector2(177.0, 29.0), Vector2(182.0, 34.0), Vector2(182.0, 38.0),
	Vector2(180.0, 40.0), Vector2(180.0, 52.0), Vector2(181.0, 52.0), Vector2(184.0, 55.0), Vector2(191.0, 55.0),
	Vector2(198.0, 58.0), Vector2(243.0, 103.0), Vector2(246.0, 110.0), Vector2(246.0, 124.0), Vector2(250.0, 128.0),
	Vector2(252.0, 139.0), Vector2(252.0, 182.0), Vector2(250.0, 193.0), Vector2(246.0, 197.0), Vector2(246.0, 211.0),
	Vector2(243.0, 218.0), Vector2(198.0, 263.0), Vector2(191.0, 266.0), Vector2(90.0, 266.0), Vector2(83.0, 263.0),
	Vector2(38.0, 218.0), Vector2(35.0, 211.0), Vector2(35.0, 197.0), Vector2(31.0, 193.0), Vector2(29.0, 182.0),
	Vector2(29.0, 139.0), Vector2(31.0, 128.0), Vector2(35.0, 124.0), Vector2(35.0, 110.0), Vector2(38.0, 103.0),
	Vector2(83.0, 58.0)])
## This is the [PackedVector2Array] that is used for the [Polygon2D] for Alert Notifications.
var alert: PackedVector2Array = PackedVector2Array([
	Vector2(90.0, 55.0), Vector2(97.0, 55.0), Vector2(100.0, 52.0), Vector2(101.0, 52.0), Vector2(101.0, 48.0),
	Vector2(95.0, 48.0), Vector2(90.0, 42.0), Vector2(89.0, 40.0), Vector2(89.0, 32.0), Vector2(90.0, 28.0),
	Vector2(95.0, 22.0), Vector2(115.0, 22.0), Vector2(119.0, 26.0), Vector2(120.0, 28.0), Vector2(121.0, 30.0),
	Vector2(121.0, 39.0), Vector2(119.0, 44.0), Vector2(116.0, 48.0), Vector2(110.0, 48.0), Vector2(110.0, 52.0),
	Vector2(111.0, 52.0), Vector2(114.0, 55.0), Vector2(167.0, 55.0), Vector2(170.0, 52.0), Vector2(171.0, 52.0),
	Vector2(171.0, 48.0), Vector2(165.0, 48.0), Vector2(162.0, 44.0), Vector2(160.0, 39.0), Vector2(160.0, 30.0),
	Vector2(161.0, 28.0), Vector2(162.0, 26.0), Vector2(166.0, 22.0), Vector2(186.0, 22.0), Vector2(191.0, 28.0),
	Vector2(192.0, 32.0), Vector2(192.0, 40.0), Vector2(191.0, 42.0), Vector2(186.0, 48.0), Vector2(180.0, 48.0),
	Vector2(180.0, 52.0), Vector2(181.0, 52.0), Vector2(184.0, 55.0), Vector2(191.0, 55.0), Vector2(198.0, 58.0),
	Vector2(243.0, 103.0), Vector2(246.0, 110.0), Vector2(246.0, 124.0), Vector2(250.0, 128.0), Vector2(252.0, 139.0),
	Vector2(252.0, 182.0), Vector2(250.0, 193.0), Vector2(246.0, 197.0), Vector2(246.0, 211.0), Vector2(243.0, 218.0),
	Vector2(198.0, 263.0), Vector2(191.0, 266.0), Vector2(90.0, 266.0), Vector2(83.0, 263.0), Vector2(38.0, 218.0),
	Vector2(35.0, 211.0), Vector2(35.0, 197.0), Vector2(31.0, 193.0), Vector2(29.0, 182.0), Vector2(29.0, 139.0),
	Vector2(31.0, 128.0), Vector2(35.0, 124.0), Vector2(35.0, 110.0), Vector2(38.0, 103.0), Vector2(83.0, 58.0)
])
# Dictionaries
## A [Dictionary] for storing the [PackedVector2Array]s of [Polygon2D]s
var borders: Dictionary = {}
# Exported Variables
# Exported Enumerations
## Sets the [enum current_polygon] to the specified [String];[br]
## This will initiate the set function that will change the window's clickable mask.
## Fires an error if not set to "Base" upon the Spookivice's launch since the [Dictionary]
## has not yet added the [Polygon2D].
@export_enum("Base", "Alert", "Polygon1") var current_polygon = "Base":
	set(new_polygon):
		if borders.has(new_polygon): polygon = borders[new_polygon]
		else: printerr("Incorrect Border Set, Switching to Base")
#------------------------------------------------------------------------------#
# Functions
# Ready
func _ready() -> void:
	borders.set("Base", base_border)
	borders.set("Alert", alert)
	borders.set("Polygon1", polygon1)
#------------------------------------------------------------------------------#
# Custom Functions
# Alert Border Switch
func alert_border(toggled_on: bool):
	current_polygon = "Alert" if toggled_on else "Base"
