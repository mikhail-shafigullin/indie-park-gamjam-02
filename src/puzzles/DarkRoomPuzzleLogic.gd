class_name DarkRoomPuzzleLogic
extends Resource

enum Direction { LEFT, RIGHT, DOWN, UP }

signal stepCorrect
signal onMistake
signal puzzleSolved

var correctSequence: Array[Direction] = [
	Direction.LEFT,
	Direction.RIGHT,
	Direction.DOWN,
	Direction.UP
]

var fullSequence: Array[Direction] = []

func tryDirection(dir: Direction) -> void:
	fullSequence.append(dir)
	print("currentSquence", fullSequence);
	var step := fullSequence.size() - 1
	if step >= correctSequence.size() or dir != correctSequence[step]:
		print("Mistake:", correctSequence, fullSequence)
		onMistake.emit()
		reset()
		return
	if fullSequence == correctSequence:
		puzzleSolved.emit()
		reset()
	else:
		print("Correct:", correctSequence, fullSequence)
		stepCorrect.emit()

func reset() -> void:
	fullSequence.clear()
