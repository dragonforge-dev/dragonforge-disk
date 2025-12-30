extends HBoxContainer

var check_status: Dictionary = {}


func _ready() -> void:
	var loaded_data: Variant = Disk.load_setting(name)
	if loaded_data is Dictionary:
		check_status = loaded_data
	for check_box in get_children():
		if check_box is CheckBox:
			if check_status.has(check_box.name):
				check_box.button_pressed = check_status[check_box.name]
			check_box.toggled.connect(_on_button_toggled.bind(check_box.name))


func _on_button_toggled(toggled_on: bool, check_box_name: String) -> void:
	check_status[check_box_name] = toggled_on
	Disk.save_setting(check_status, name)
