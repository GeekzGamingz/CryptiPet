extends HBoxContainer
#------------------------------------------------------------------------------#
# Variables
# Exported Variables
@export_enum("1","2","3","4","5","6",) var die1_face: String = "1":
	set(new_face): if die1 != null: die1.frame = int(new_face) - 1
@export_enum("1","2","3","4","5","6",) var die2_face: String = "1":
	set(new_face): if die2 != null: die2.frame = int(new_face) - 1
# OnReady Variables
@onready var die1: Sprite2D = $D1Container/Die1
@onready var die2: Sprite2D = $D2Container/Die2
#------------------------------------------------------------------------------#
