extends Level

@onready var starterMarker: Marker2D = %Start;
@onready var puzzle3Button: Usable = %Solve3;
@onready var changeScene: Usable = %ChangeScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_enters_room.connect(closeDoorFor3rdPuzzle);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func closeDoorFor3rdPuzzle():
	if(PuzzleStates.puzzle12Solved == true and 
	PuzzleStates.puzzle3Solved != true):
		changeScene.disable();


func _on_solve_3__object_used() -> void:
	puzzle3Button.disable();
	MainEventBus.puzzle_3_solved.emit();
	changeScene.enable()
