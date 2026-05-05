extends Node

var debugLevel: Level;
var mainHallLevel: Level;
var mcRoomLevel: Level;
var bathroomLevel: Level;
var bedroomLevel: Level;

func _ready() -> void:
	debugLevel = load("uid://0oe7olk4j1sr").instantiate();
	mainHallLevel = load("uid://cvjhdejsco1hk").instantiate();
	mcRoomLevel = load("uid://t0wxmyah42nb").instantiate();
	pass;
