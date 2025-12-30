class_name FloatTest extends HBoxContainer

@onready var spin_box: SpinBox = $SpinBox

func _ready() -> void:
	var loaded_value: Variant = Disk.load_setting(name)
	if loaded_value is float:
		spin_box.value = loaded_value
	spin_box.value_changed.connect(_on_value_changed)


func _on_value_changed(value: float) -> void:
	Disk.save_setting(value, name)
