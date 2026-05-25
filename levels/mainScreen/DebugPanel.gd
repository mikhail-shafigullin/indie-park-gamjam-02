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
	LevelContainer.debugLevel.sendPlayerToMarker("Start")


func _on_to_main_hall_pressed() -> void:
	LevelContainer.mainHallLevel.sendPlayerToMarker("Start")


func _on_to_mc_room_pressed() -> void:
	LevelContainer.mcRoomLevel.sendPlayerToMarker("Start")


func _on_to_bathroom_pressed() -> void:
	LevelContainer.bathroomLevel.sendPlayerToMarker("Start")


func _on_to_bedroom_pressed() -> void:
	LevelContainer.bedroomLevel.sendPlayerToMarker("Start")


func _on_to_dark_room_pressed() -> void:
	LevelContainer.darkRoomLevel.sendPlayerToMarker("Start")
