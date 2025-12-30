extends LineEdit


func _ready() -> void:
	var loaded_value: Variant = Disk.load_setting("StringTest")
	if loaded_value is String:
		text = loaded_value
	text_changed.connect(_on_text_changed)


func _on_text_changed(new_text: String) -> void:
	Disk.save_setting(new_text, "StringTest")
