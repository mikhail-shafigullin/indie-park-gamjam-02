extends Usable

var puzzleIsSolved: bool = false;
var used = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainEventBus.puzzle_2_solved.connect(closeThePuzzleWhenPuzzleIsSolved)
	pass # Replace with function body.

func useObject():
	if(!used): 
		PuzzleStates.mcRoomTVPuzzleLogic.initPuzzle();
		used = true;
	if(puzzleIsSolved):
		Dialogic.start('MCRoomTVPuzzleAlreadySolved');
	else:
		Dialogic.start('MCRoomTVUseWithoutCartridge');

func closeThePuzzleWhenPuzzleIsSolved():
	puzzleIsSolved = true;
