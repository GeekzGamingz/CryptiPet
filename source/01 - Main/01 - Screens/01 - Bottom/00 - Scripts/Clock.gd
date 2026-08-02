extends RichTextLabel
#------------------------------------------------------------------------------#
# Functions
# Process
func _process(_delta: float) -> void: update_time()
#------------------------------------------------------------------------------#
# Custom Functions
# Update Spookivice Time
func update_time():
	# Get System Time
	var time_dictionary: Dictionary = Time.get_time_dict_from_system()
	# Convert Hour
	var twelfth_hour: int = 12 if time_dictionary.hour % 12 == 0 else time_dictionary.hour % 12
	var hour: String = "%s" % int(twelfth_hour)
	var minute: String = "%02d" % time_dictionary.minute
	var meridian: String = "AM" if time_dictionary.hour < 12 else "PM"
	# Output Time
	text = "%s:%s%s" % [hour, minute, meridian]
