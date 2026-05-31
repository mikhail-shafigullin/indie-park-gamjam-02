extends Level

func _ready() -> void:
	MainEventBus.usable_object_is_unhovered.emit(self);
