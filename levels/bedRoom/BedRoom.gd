extends Level

@onready var starterMarker: Marker2D = %Start;
@onready var puzzle4Button: Usable = %Solve4;
@onready var changeScene: Usable = %ChangeScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_enters_room.connect(closeDoorFor4thPuzzle);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func closeDoorFor4thPuzzle():
	if(PuzzleStates.puzzle13Solved == true and 
	PuzzleStates.puzzle4Solved != true):
		changeScene.disable();


func _on_solve_4__object_used() -> void:
	puzzle4Button.disable();
	MainEventBus.puzzle_4_solved.emit();
	changeScene.enable()
