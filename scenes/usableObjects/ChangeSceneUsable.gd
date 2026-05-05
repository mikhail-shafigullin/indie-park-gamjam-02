extends Usable


func useObject():
	MainEventBus.level_change.emit(LevelContainer.mcRoomLevel);
