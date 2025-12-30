class_name OnOffCheckButton extends CheckButton

@onready var on_off_label: Label = %OnOffLabel


func _ready() -> void:
	toggled.connect(_on_button_toggled)
	button_pressed = true if Disk.load_setting(name) else false


func _on_button_toggled(toggled_on: bool) -> void:
	on_off_label.text = "On" if toggled_on else "Off"
	Disk.save_setting(toggled_on, name)
