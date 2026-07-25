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
func add_message(message, timeout, priority):
	var notification_scene = NOTIFICATION.instantiate()
	notifications.add_child(notification_scene)
	notification_scene.load_message(message, timeout)
	notification_scene.priority = priority
	for notice in notifications.get_children():
		if !notice.priority && notice != notification_scene: notice.queue_free()
# Clear Messages
func clear_messages():
	for notice in notifications.get_children(): notice.queue_free()
