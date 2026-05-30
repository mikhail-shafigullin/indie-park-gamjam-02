extends DarkRoomPuzzleRoom

@onready var puzzle4Button: Usable = %Solve4
@onready var changeScene: Usable = %ChangeScene

func onPlayerEntersRoom() -> void:
	super.onPlayerEntersRoom()
	closeDoorFor4thPuzzle()

func closeDoorFor4thPuzzle() -> void:
	if PuzzleStates.puzzle13Solved == true and PuzzleStates.puzzle4Solved != true:
		changeScene.disable()

func onStepCorrect() -> void:
	LevelContainer.darkRoomLevel.sendPlayerToMarker("Start")

func _on_solve_4__object_used() -> void:
	puzzle4Button.disable()
	MainEventBus.puzzle_4_solved.emit()
	changeScene.enable()
