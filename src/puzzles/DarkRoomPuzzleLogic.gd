class_name DarkRoomPuzzleLogic
extends Resource

enum Direction { LEFT, RIGHT, DOWN, UP }

signal stepCorrect
signal firstMistake
signal secondMistake
signal puzzleSolved

var correctSequence: Array[Direction] = [
	Direction.LEFT,
	Direction.RIGHT,
	Direction.DOWN,
	Direction.UP
]

var currentStep: int = 0
var errorCount: int = 0

func tryDirection(dir: Direction) -> void:
	if currentStep >= correctSequence.size():
		return
	if dir == correctSequence[currentStep]:
		currentStep += 1
		if currentStep >= correctSequence.size():
			puzzleSolved.emit()
			reset()
		else:
			stepCorrect.emit()
	else:
		currentStep = 0
		errorCount += 1
		if errorCount >= 2:
			secondMistake.emit()
			reset()
		else:
			firstMistake.emit()

func reset() -> void:
	currentStep = 0
	errorCount = 0
