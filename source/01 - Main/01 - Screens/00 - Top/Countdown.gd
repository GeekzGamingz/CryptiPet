extends RichTextLabel
#------------------------------------------------------------------------------#
# Variables
var morph_timer: Timer
#------------------------------------------------------------------------------#
# Functions
func _process(_delta: float) -> void:
	if is_instance_valid(morph_timer) && !morph_timer.is_stopped():
		update_countdown(morph_timer.time_left)
#------------------------------------------------------------------------------#
func update_countdown(parsed_seconds: float) -> void:
	var total_seconds: float = floor(parsed_seconds)
	var minutes: int = floor(total_seconds / 60)
	var seconds: int = int(total_seconds) % 60
	if total_seconds <= 10: text = "[color=e92719]%02d:%02d[/color]" % [minutes, seconds]
	elif total_seconds <= 30: text = "[color=eddc3c]%02d:%02d[/color]" % [minutes, seconds]
	else: text = "[color=f0ebeb]%02d:%02d[/color]" % [minutes, seconds]
