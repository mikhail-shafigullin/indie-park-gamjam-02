extends DarkRoomPuzzleRoom

@onready var puzzle4Button: Usable = %Solve4
@onready var changeScene: Usable = %ChangeScene

func onPlayerEntersRoom() -> void:
	super.onPlayerEntersRoom()
	closeDoorFor4thPuzzle()
	MainEventBus.puzzle_4_solved.connect(openDoor)

func closeDoorFor4thPuzzle() -> void:
	if PuzzleStates.puzzle13Solved == true and PuzzleStates.puzzle4Solved != true:
		changeScene.disable()

func onStepCorrect() -> void:
	LevelContainer.darkRoomLevel.sendPlayerToMarker("Start")

func _on_solve_4__object_used() -> void:
	MainEventBus.puzzle_4_solved.emit()

func openDoor():
	puzzle4Button.disable()
	changeScene.enable()
	$Door/ClosedDoorSprite.visible = false;
	$Door/OpenedDoorSprite.visible = true;
