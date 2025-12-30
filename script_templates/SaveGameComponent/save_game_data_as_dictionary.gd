# meta-description: For saving multiple pieces of game information in a Dictionary.
# meta-default: true

## Change this [code]class_name[/code] so that it will appear in the [b]Create New Node[/b] dialog.
class_name SaveGameDataAsDictionary
extends SaveGameComponent


## Called when [method Disk.save_game] is called.
## Implement this function to return data from the [member subject] node.
func save_node() -> Dictionary:
	var save_data: Dictionary = {
		"parent_node_name": subject.name
	}
	return save_data
