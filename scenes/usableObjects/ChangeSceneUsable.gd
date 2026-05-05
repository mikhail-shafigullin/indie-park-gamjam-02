extends Usable

@export_enum("Debug", "MainRoom", "McRoom", "Bathroom", "Bedroom") var levelId: int;
@export var markerName: String;

func useObject():
	var level: Level = LevelContainer.allLevels[levelId];
	level.sendPlayerToMarker(markerName)
	
