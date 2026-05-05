extends Control

@export var debugLevel: PackedScene;
@export var mainHallLevel: PackedScene;
@export var mcRoom: PackedScene;
@export var bathRoom: PackedScene;
@export var bedRoom: PackedScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_to_debug_level_pressed() -> void:
	MainEventBus.level_change.emit(LevelContainer.debugLevel);


func _on_to_main_hall_pressed() -> void:
	MainEventBus.level_change.emit(LevelContainer.mainHallLevel);


func _on_to_mc_room_pressed() -> void:
	MainEventBus.level_change.emit(LevelContainer.mcRoomLevel);


func _on_to_bathroom_pressed() -> void:
	MainEventBus.level_change.emit(LevelContainer.bathroomLevel);


func _on_to_bedroom_pressed() -> void:
	MainEventBus.level_change.emit(LevelContainer.bedroomLevel);
