extends Level

@onready var starterMarker: Marker2D = %Start;
@onready var puzzle2Button: Usable = %Solve2;
@onready var changeScene: Usable = %ChangeScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_enters_room.connect(closeDoorFor2ndPuzzle);
	MainEventBus.puzzle_2_solved.connect(openTheDoorWhenPuzzleIsSolved)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func closeDoorFor2ndPuzzle():
	if(PuzzleStates.puzzle11Solved == true and 
	PuzzleStates.puzzle2Solved != true):
		changeScene.disable();

func openTheDoorWhenPuzzleIsSolved() -> void:
	puzzle2Button.disable();
	changeScene.enable()

func _on_solve_2__object_used() -> void:
	MainEventBus.puzzle_2_solved.emit();
	
