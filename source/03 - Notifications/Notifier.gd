extends Control
#------------------------------------------------------------------------------#
# Constants
const NOTIFICATION = preload("uid://dov63udho8a2v")
#------------------------------------------------------------------------------#
# Variables
# OnReady Variables
@onready var notifications: VBoxContainer = $Notifications
#------------------------------------------------------------------------------#
# Custom Functions
# Add Message
func add_message(message: String, timeout: float, priority: bool) -> void:
	var current_notifications = notifications.get_children()
	# Priority Check
	for notice in current_notifications: if notice.priority: return
	# Notification Setup
	var notification_scene = NOTIFICATION.instantiate()
	notifications.add_child(notification_scene)
	notification_scene.load_message(message, timeout)
	notification_scene.priority = priority
	# Remove Non-Priority Notifications
	for notice in current_notifications: notice.queue_free()
# Clear Messages
func clear_messages() -> void:
	for notice in notifications.get_children(): notice.queue_free()
