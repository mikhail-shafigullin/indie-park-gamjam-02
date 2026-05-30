extends Node

var puzzle11Solved: bool = false;
var puzzle12Solved: bool = false;
var puzzle13Solved: bool = false;
var puzzle2Solved: bool = false;
var puzzle3Solved: bool = false;
var puzzle4Solved: bool = false;

var mcRoomTVPuzzleLogic: MCRoomTVPuzzleLogic;
var bathroomDollPuzzleLogic: BathRoomDollPuzzleLogic;
var darkRoomPuzzleLogic: DarkRoomPuzzleLogic;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainEventBus.puzzle_1_1_solved.connect(func(): puzzle11Solved = true);
	MainEventBus.puzzle_1_2_solved.connect(func(): puzzle12Solved = true);
	MainEventBus.puzzle_1_3_solved.connect(func(): puzzle13Solved = true);
	MainEventBus.puzzle_2_solved.connect(func(): puzzle2Solved = true);
	MainEventBus.puzzle_3_solved.connect(func(): puzzle3Solved = true);
	MainEventBus.puzzle_4_solved.connect(func(): puzzle4Solved = true);
	
	mcRoomTVPuzzleLogic = MCRoomTVPuzzleLogic.new();
	bathroomDollPuzzleLogic = BathRoomDollPuzzleLogic.new();
	darkRoomPuzzleLogic = DarkRoomPuzzleLogic.new();

func startPuzzle(scenePath: String):
	MainEventBus.puzzle_layer_show_scene.emit(load(scenePath).instantiate())

func finishPuzzle():
	Global.currentPuzzle = null;
	MainEventBus.puzzle_layer_exit.emit();
