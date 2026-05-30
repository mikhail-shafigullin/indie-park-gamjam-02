extends DarkRoomPuzzleRoom
	
func onStepCorrect() -> void:
	LevelContainer.darkRoomLevel.sendPlayerToMarker("Start")
