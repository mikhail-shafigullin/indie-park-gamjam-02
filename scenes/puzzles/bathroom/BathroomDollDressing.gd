extends Control

@onready var bodiesContainter: Control = %body;
@onready var mouthsContainer: Control = %mouth;
@onready var eyesContainer: Control = %eyes;
@onready var hairsContainer: Control = %hair

var bodiesList: Array[TextureRect];
var mouthsList: Array[TextureRect];
var eyesList: Array[TextureRect];
var hairsList: Array[TextureRect];

var bodiesIndex: int = 0;
var mouthsIndex: int = 0;
var eyesIndex: int = 0;
var hairsIndex: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bodiesList.push_back(null);
	for child in bodiesContainter.get_children():
		if(child.name == 'body_base'):
			continue;
		bodiesList.push_back(child);
	
	for child in mouthsContainer.get_children():
		mouthsList.push_back(child)
	
	for child in eyesContainer.get_children():
		eyesList.push_back(child)
		
	for child in hairsContainer.get_children():
		hairsList.push_back(child)
	setPuzzle(PuzzleStates.bathroomDollPuzzleLogic.currentDollState);

func setPuzzle(initialDollState: Array[int]):
	chooseBodyByIndex(initialDollState[0]);
	chooseMouthByIndex(initialDollState[1]);
	chooseEyesByIndex(initialDollState[2]);
	chooseHairByIndex(initialDollState[3]);

func chooseBody(isRight: bool):
	var nextIndex = bodiesIndex+1 if isRight else bodiesIndex-1;
	chooseBodyByIndex(nextIndex);

func chooseHair(isRight: bool):
	var nextIndex = hairsIndex+1 if isRight else hairsIndex-1;
	chooseHairByIndex(nextIndex)

func chooseEyes(isRight: bool):
	var nextIndex = eyesIndex+1 if isRight else eyesIndex-1;
	chooseEyesByIndex(nextIndex);

func chooseMouth(isRight: bool):
	var nextIndex = mouthsIndex+1 if isRight else mouthsIndex-1;
	chooseMouthByIndex(nextIndex)

func chooseBodyByIndex(index):
	var currentBody = bodiesList[bodiesIndex];
	if(currentBody != null): 
		currentBody.visible = false;
	bodiesIndex = index;
	if(bodiesIndex >= bodiesList.size() ):
		bodiesIndex = 0;
	elif(bodiesIndex < 0):
		bodiesIndex = bodiesList.size() - 1;
	var nextBody = bodiesList[bodiesIndex];
	if(nextBody != null):
		nextBody.visible = true;
	PuzzleStates.bathroomDollPuzzleLogic.setBody(bodiesIndex);

func chooseHairByIndex(nextIndex):
	var currentBody = hairsList[hairsIndex];
	currentBody.visible = false;
	hairsIndex = nextIndex;
	if(hairsIndex >= hairsList.size() ):
		hairsIndex = 0;
	elif(hairsIndex < 0):
		hairsIndex = hairsList.size() - 1;
	var nextBody = hairsList[hairsIndex];
	PuzzleStates.bathroomDollPuzzleLogic.setHair(hairsIndex);
	nextBody.visible = true;

func chooseEyesByIndex(nextIndex):
	var currentBody = eyesList[eyesIndex];
	currentBody.visible = false;
	eyesIndex = nextIndex
	if(eyesIndex >= eyesList.size() ):
		eyesIndex = 0;
	elif(eyesIndex < 0):
		eyesIndex = eyesList.size() - 1;
	var nextBody = eyesList[eyesIndex];
	PuzzleStates.bathroomDollPuzzleLogic.setEyes(eyesIndex)
	nextBody.visible = true;

func chooseMouthByIndex(nextIndex):
	var currentBody = mouthsList[mouthsIndex];
	currentBody.visible = false;
	mouthsIndex = nextIndex;
	if(mouthsIndex >= mouthsList.size() ):
		mouthsIndex = 0;
	elif(mouthsIndex < 0):
		mouthsIndex = mouthsList.size() - 1;
	var nextBody = mouthsList[mouthsIndex];
	PuzzleStates.bathroomDollPuzzleLogic.setMouth(mouthsIndex)
	nextBody.visible = true;

func _on_hair_button_left_pressed() -> void:
	chooseHair(false)

func _on_hair_button_right_pressed() -> void:
	chooseHair(true)

func _on_clothes_button_left_pressed() -> void:
	chooseBody(false);

func _on_clothes_button_right_pressed() -> void:
	chooseBody(true);

func _on_eyes_button_left_pressed() -> void:
	chooseEyes(false);

func _on_eyes_button_right_pressed() -> void:
	chooseEyes(true);

func _on_mouth_button_left_pressed() -> void:
	chooseMouth(false);

func _on_mouth_button_right_pressed() -> void:
	chooseMouth(true);
