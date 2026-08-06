extends MarginContainer
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
@export_multiline var full_string: String
# OnReady Variables
@onready var item: TextureRect = $VBoxContainer/HBoxContainer/PanelContainer/Item
@onready var text_top: RichTextLabel = $VBoxContainer/HBoxContainer/TextTop
@onready var text_bottom: RichTextLabel = $VBoxContainer/TextBottom
#------------------------------------------------------------------------------#
# Custom Functions
func wrap_text(text: String) -> void:
	# Clear Previous Text
	text_top.fit_content = false
	text_top.text = ""
	text_bottom.text = ""
	# Update Top & Await
	text_top.text = text
	await get_tree().process_frame
	# Grab Paragraph Information
	var font: Font = text_top.get_theme_font("normal_font")
	var font_size: int = text_top.get_theme_font_size("normal_font_size")
	var line_spacing: int = text_top.get_theme_constant("line_separation")
	var current_height: float = font.get_height(font_size) + line_spacing
	var max_lines: int = floor(text_top.size.y / current_height)
	var total_lines: int = text_top.get_line_count()
	# Find Paragraph Limitations
	if total_lines > max_lines:
		var total_visible: int = 0
		var total_characters: int = text.length()
		for character in total_characters:
			if text_top.get_character_line(character) > max_lines:
				total_visible = character
				break
		# Slice Text
		if total_visible < text.length() && total_visible > 0:
			text_top.text = text.left(total_visible)
			text_bottom.text = text.substr(total_visible)
		else: # Split Not Needed
			text_top.text = text
			text_bottom.text = ""
	# Fit Top Content for Character Descenders
	text_top.fit_content = true
