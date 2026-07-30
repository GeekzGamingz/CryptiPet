extends RichTextLabel
#------------------------------------------------------------------------------#
# Functions
# Process
func _process(_delta: float) -> void:
	var time_dictionary: Dictionary = Time.get_time_dict_from_system()
	var hour: String = "%s" % int(time_dictionary.hour % 12)
	var minute: String = "%02d" % time_dictionary.minute
	var meridian: String = "AM"
	if time_dictionary.hour > 12: meridian = "PM"
	text = "%s:%s%s" % [hour, minute, meridian]
