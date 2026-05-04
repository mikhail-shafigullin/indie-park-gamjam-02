extends Control

@export var debugLevel: PackedScene;
@export var mainHallLevel: PackedScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_to_debug_level_pressed() -> void:
	MainEventBus.level_change.emit(debugLevel);


func _on_to_main_hall_pressed() -> void:
	MainEventBus.level_change.emit(mainHallLevel);
