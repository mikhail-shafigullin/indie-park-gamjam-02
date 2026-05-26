class_name BathRoomDollPuzzleLogic
extends Resource

var currentDollState: Array[int] = [0, 0, 0, 0];
var correctDollState: Array[int] = [1, 2, 3, 0];
signal takeCorrectPhoto;
signal takeIncorrectPhoto;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setBody(index: int):
	currentDollState[0] = index;

func setMouth(index: int):
	currentDollState[1] = index;

func setEyes(index: int):
	currentDollState[2] = index;

func setHair(index: int):
	currentDollState[3] = index;

func checkPhoto():
	for index in currentDollState.size():
		if(currentDollState[index] != correctDollState[index]):
			takeIncorrectPhoto.emit();
			return;
	takeCorrectPhoto.emit();
