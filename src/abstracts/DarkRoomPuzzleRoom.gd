class_name DarkRoomPuzzleRoom
extends Level

var puzzleLogic: DarkRoomPuzzleLogic
var isRespawning: bool = false
var isBoundaryCooldown: bool = false
var timer: Timer = Timer.new()
var TIME_COOLDOWN = 1.0;

func _ready() -> void:
	if not puzzleLogic:
		puzzleLogic = DarkRoomPuzzleLogic.new()
		puzzleLogic.stepCorrect.connect(onStepCorrect)
		puzzleLogic.firstMistake.connect(onFirstMistake)
		puzzleLogic.secondMistake.connect(onSecondMistake)
		puzzleLogic.puzzleSolved.connect(onPuzzleSolved)
	if not player_enters_room.is_connected(onPlayerEntersRoom):
		player_enters_room.connect(onPlayerEntersRoom)
	timer.wait_time = TIME_COOLDOWN;
	add_child(timer);
	timer.one_shot = true
	timer.timeout.connect(setBoundaryCooldown);

func onPlayerEntersRoom() -> void:
	if not isRespawning:
		puzzleLogic.reset()
	isRespawning = false

func onBoundaryLeft(body: Node2D) -> void:
	if not body is PlayerController or isBoundaryCooldown:
		return
	timerCooldown()
	isRespawning = true
	puzzleLogic.tryDirection(DarkRoomPuzzleLogic.Direction.LEFT)

func onBoundaryRight(body: Node2D) -> void:
	if not body is PlayerController or isBoundaryCooldown:
		return
	timerCooldown()
	isRespawning = true
	puzzleLogic.tryDirection(DarkRoomPuzzleLogic.Direction.RIGHT)

func onBoundaryUp(body: Node2D) -> void:
	if not body is PlayerController or isBoundaryCooldown:
		return
	timerCooldown()
	isRespawning = true
	puzzleLogic.tryDirection(DarkRoomPuzzleLogic.Direction.UP)

func onBoundaryDown(body: Node2D) -> void:
	if not body is PlayerController or isBoundaryCooldown:
		return
	timerCooldown()
	isRespawning = true
	puzzleLogic.tryDirection(DarkRoomPuzzleLogic.Direction.DOWN)

func timerCooldown():
	isBoundaryCooldown = true
	timer.start();

func setBoundaryCooldown():
	isBoundaryCooldown = false;

func onStepCorrect() -> void:
	pass

func onFirstMistake() -> void:
	pass

func onSecondMistake() -> void:
	pass

func onPuzzleSolved() -> void:
	MainEventBus.puzzle_4_solved.emit();
