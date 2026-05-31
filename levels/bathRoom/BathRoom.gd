extends Level

@onready var starterMarker: Marker2D = %Start;
@onready var puzzle3Button: Usable = %Solve3;
@onready var changeScene: Usable = %ChangeScene;
@onready var openedDoor: Sprite2D = $DoorOpened;
@onready var closedDoor: Sprite2D = $DoorClosed;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_enters_room.connect(closeDoorFor3rdPuzzle);
	MainEventBus.puzzle_3_solved.connect(_on_puzzle_finished)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func closeDoorFor3rdPuzzle():
	if(PuzzleStates.puzzle12Solved == true and 
	PuzzleStates.puzzle3Solved != true):
		changeScene.disable();


func _on_solve_3__object_used() -> void:
	MainEventBus.puzzle_3_solved.emit();

func _on_puzzle_finished():
	puzzle3Button.disable();
	changeScene.enable()
	closedDoor.visible = false;
	openedDoor.visible = true;
