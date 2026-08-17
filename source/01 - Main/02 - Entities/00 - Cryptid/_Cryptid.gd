@icon("res://assets/01 - Icons/Cryptidood.png")
extends CharacterBody2D
class_name Cryptid
## Cryptid
##
## All [Cryptid]s inherit from [CharacterBody2D]. The player never has direct control[br]
## over the [Cryptid] and only can influence its behaviors by tending to its needs.
#------------------------------------------------------------------------------#
# Variables
## Stores the bool variable "Hiding"; Used for Despawning the [Cryptid]
var hiding: bool = false
# OnReady Variables
# Main Nodes
@onready var SPOOKIVICE: Control = get_tree().get_root().get_node("Spookivice")
# Local Nodes
# Attributes
## Returns the [Node2D] of the [Cryptid]'s Movement Component.
@onready var movement: Node2D = $Scripts/Movement
## Returns the [Node2D] of the [Cryptid]'s Concept Component.
@onready var concept: Node2D = $Scripts/Concept
## Returns the [Node2D] of the [Cryptid]'s Happiness Component.
@onready var happiness: Node2D = $Scripts/Happiness
## Returns the [Node2D] of the [Cryptid]'s Hunger Component.
@onready var hunger: Node2D = $Scripts/Hunger
## Returns the [Node2D] of the [Cryptid]'s Health Component.
@onready var health: Node2D = $Scripts/Health
# Sprites
## Returns the base [Sprite2D] of the [Cryptid].
@onready var sprite_base: Sprite2D = $Sprites/Base
# RayCasts
## Returns the Northern [RayCast2D] of the [Cryptid].
@onready var ray_north: RayCast2D = $Raycasts/North
## Returns the Eastern [RayCast2D] of the [Cryptid].
@onready var ray_east: RayCast2D = $Raycasts/East
## Returns the Southern[RayCast2D] of the [Cryptid].
@onready var ray_south: RayCast2D = $Raycasts/South
## Returns the Western [RayCast2D] of the [Cryptid].
@onready var ray_west: RayCast2D = $Raycasts/West
# Animation Players
## Returns the [Sprite2D] [AnimationPlayer]
@onready var sprite_player: AnimationPlayer = $Players/Animation/Sprites
#------------------------------------------------------------------------------#
