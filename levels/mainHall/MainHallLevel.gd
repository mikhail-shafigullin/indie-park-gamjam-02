extends Level

@onready var markerStartGame: Marker2D = %Start;
@onready var solve11Button: Usable = %Solve11;
@onready var solve12Button: Usable = %Solve12;
@onready var solve13Button: Usable = %Solve13;
@onready var changeSceneToMcRoom: Usable = %ChangeSceneToMcRoom
@onready var changeSceneToBedRoom: Usable = %ChangeSceneToBedRoom
@onready var changeSceneToBathRoom: Usable = %ChangeSceneToBathRoom

@onready var purpleDoor: ApartmentDoor = %PurpleDoor
@onready var blueDoor: ApartmentDoor = %BlueDoor
@onready var redDoor: ApartmentDoor = %RedDoor

@onready var anim: AnimationPlayer = %Anim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_enters_room.connect(giveAccessToPuzzles);
	MainEventBus.puzzle_1_1_solved.connect(openMcRoom);
	MainEventBus.puzzle_1_2_solved.connect(openBathroom);
	MainEventBus.puzzle_1_3_solved.connect(openBedroom)
	MainEventBus.request_rpg.connect(clear_black);
	play_intro()
	pass;

func giveAccessToPuzzles():
	if(PuzzleStates.puzzle2Solved and !PuzzleStates.puzzle12Solved):
		solve12Button.enable();
	if(PuzzleStates.puzzle3Solved and !PuzzleStates.puzzle13Solved):
		#changeSceneToBathRoom.disable();
		solve13Button.enable();
	if(PuzzleStates.puzzle4Solved):
		changeSceneToBedRoom.disable();

func play_intro():
	#Dialogic.start("MainHallEnding")
	Dialogic.start("MainHallWakeUp")
		
func openMcRoom():
	Dialogic.start('MainHallPuzzleSolved');
	purpleDoor.open();
	solve11Button.disable();
	changeSceneToMcRoom.enable();

func openBathroom():
	Dialogic.start('MainHallPuzzleSolved');
	blueDoor.open();
	solve12Button.disable();
	changeSceneToBathRoom.enable();
	
func openBedroom():
	Dialogic.start('MainHallPuzzleSolved');
	redDoor.open();
	solve13Button.disable();
	changeSceneToBedRoom.enable();

func _on_solve_11__object_used() -> void:
	MainEventBus.puzzle_1_1_solved.emit();

func _on_solve_12__object_used() -> void:
	MainEventBus.puzzle_1_2_solved.emit();

func _on_solve_13__object_used() -> void:
	MainEventBus.puzzle_1_3_solved.emit();
	
	
func clear_black() -> void:
	%FadeLayer.visible = false
