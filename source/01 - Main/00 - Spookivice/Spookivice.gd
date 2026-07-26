extends Control
## Spookivice
##
## This node manages the [Cryptid]'s Spookivice. The device that binds and keeps
## your [Cryptid] from being set loose into the real world.[br]
## This is your responsibility.[br]
## This is your curse...
#------------------------------------------------------------------------------#
# Variables
var dragPoint = null
# Exported Variables
@export var border: Polygon2D
# OnReady Variables
@onready var fsm: StateMachine = $StateMachine
@onready var outputs: Node2D = $Outputs
@onready var top_screen: TextureRect = $Screens/TopScreen
@onready var bottom_screen: TextureRect = $Screens/BottomScreen
@onready var buttons: Control = $Buttons
@onready var toggles: Control = $Toggles
@onready var notifier: Control = $Notifier
@onready var texture_player: AnimationPlayer = $Players/Animations/Spookivice
#------------------------------------------------------------------------------#
# Functions
# Process
func _process(_delta: float) -> void: update_passthrough_mask.call_deferred()
# Has Point Override
func _has_point(point: Vector2) -> bool:
	var local_point: Vector2 = point - border.position
	return Geometry2D.is_point_in_polygon(local_point, border.polygon)
#------------------------------------------------------------------------------#
# Signaled Functions
# GUI Input
func _on_gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed: 
				if _has_point(get_global_mouse_position()):
					dragPoint = DisplayServer.mouse_get_position() - DisplayServer.window_get_position()
			else: dragPoint = null
	if event is InputEventMouseMotion && dragPoint != null:
		DisplayServer.window_set_position(DisplayServer.mouse_get_position() - dragPoint)
#------------------------------------------------------------------------------#
# Custom Functions
# Update Passthrough Mask
func update_passthrough_mask() -> void:
	if !border: return
	# Get Project Settings
	var base_width: float = ProjectSettings.get_setting("display/window/size/viewport_width")
	var base_height: float = ProjectSettings.get_setting("display/window/size/viewport_height")
	var override_width: float = ProjectSettings.get_setting("display/window/size/window_width_override")
	var override_height: float = ProjectSettings.get_setting("display/window/size/window_height_override")
	# Compare Dimensions
	if override_height == 0: override_height = base_height
	if override_width == 0: override_width = base_width
	# Caluclate Scale
	var scale_factor = Vector2(override_width / base_width, override_height / base_height)
	var scaled_points = PackedVector2Array()
	# Transform
	var xform: Transform2D = border.get_global_transform_with_canvas()
	for vertex in border.polygon:
		var window_space_vertex = xform * vertex
		var final_scaled_vertex = window_space_vertex * scale_factor
		scaled_points.append(final_scaled_vertex)
	DisplayServer.window_set_mouse_passthrough(scaled_points)
