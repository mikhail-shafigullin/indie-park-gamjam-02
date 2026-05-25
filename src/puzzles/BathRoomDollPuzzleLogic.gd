class_name BathRoomDollPuzzleLogic
extends Resource

var currentDollState: Array[int] = [0, 0, 0, 0];

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
