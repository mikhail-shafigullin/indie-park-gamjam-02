extends Node

var debugLevel: Level;
var mainHallLevel: Level;
var mcRoomLevel: Level;
var bathroomLevel: Level;
var bedroomLevel: Level;
var darkRoomLevel: Level;
var bedRoomSecondPart: Level;

var currentLevel: Level;

var allLevels: Dictionary[int, Level]

func _ready() -> void:
	debugLevel = load("uid://0oe7olk4j1sr").instantiate();
	mainHallLevel = load("uid://cvjhdejsco1hk").instantiate();
	mcRoomLevel = load("uid://t0wxmyah42nb").instantiate();
	bathroomLevel = load("uid://dba2o6o7n8kwb").instantiate();
	bedroomLevel = load("uid://bd1q8hoffopye").instantiate();
	darkRoomLevel = load("uid://b5m2kqanwq7st").instantiate();
	bedRoomSecondPart = load("uid://b80gc8qdssvq0").instantiate();
	

	allLevels[0] = debugLevel;
	allLevels[1] = mainHallLevel;
	allLevels[2] = mcRoomLevel;
	allLevels[3] = bathroomLevel;
	allLevels[4] = bedroomLevel;
	allLevels[5] = darkRoomLevel;
	pass;
