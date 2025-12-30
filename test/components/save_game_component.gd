@icon("res://assets/textures/icons/floppy-disk-green-save-game.svg")
@abstract class_name SaveGameComponent extends Node

## The node to which this [SaveGameComponent] is attached and operates on.
var subject: Node


func _ready() -> void:
	add_to_group("Persist", true)


# Guarantees this gets run if the node is added after it has been made, or is
# reparented.
func _enter_tree() -> void:
	subject = get_parent()


## Called when [method Disk.save_game] is called.
## Implement this function to return data from the [member subject] node.
@abstract
func save_node() -> Dictionary
