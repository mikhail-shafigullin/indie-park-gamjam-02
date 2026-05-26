extends DarkRoomPuzzleRoom

func onStepCorrect() -> void:
	sendPlayerToMarker("Start")

func onFirstMistake() -> void:
	sendPlayerToMarker("Start")

func onSecondMistake() -> void:
	isRespawning = false
	LevelContainer.bedroomLevel.sendPlayerToMarker("Start")

func onPuzzleSolved() -> void:
	MainEventBus.puzzle_4_solved.emit();
	LevelContainer.bedRoomSecondPart.sendPlayerToMarker("Start")
