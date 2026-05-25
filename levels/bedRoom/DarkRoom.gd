extends Level

@onready var startMarker: Marker2D = %Start

var puzzleLogic: DarkRoomPuzzleLogic
var isRespawning: bool = false
var isBoundaryCooldown: bool = false

func _ready() -> void:
	if not puzzleLogic:
		puzzleLogic = DarkRoomPuzzleLogic.new()
		puzzleLogic.stepCorrect.connect(onStepCorrect)
		puzzleLogic.firstMistake.connect(onFirstMistake)
		puzzleLogic.secondMistake.connect(onSecondMistake)
		puzzleLogic.puzzleSolved.connect(onPuzzleSolved)
	if not player_enters_room.is_connected(onPlayerEntersRoom):
		player_enters_room.connect(onPlayerEntersRoom)

func onPlayerEntersRoom() -> void:
	isBoundaryCooldown = false
	if not isRespawning:
		puzzleLogic.reset()
	isRespawning = false

func onBoundaryLeft(body: Node2D) -> void:
	if not body is PlayerController or isBoundaryCooldown:
		return
	isBoundaryCooldown = true
	isRespawning = true
	puzzleLogic.tryDirection(DarkRoomPuzzleLogic.Direction.LEFT)

func onBoundaryRight(body: Node2D) -> void:
	if not body is PlayerController or isBoundaryCooldown:
		return
	isBoundaryCooldown = true
	isRespawning = true
	puzzleLogic.tryDirection(DarkRoomPuzzleLogic.Direction.RIGHT)

func onBoundaryUp(body: Node2D) -> void:
	if not body is PlayerController or isBoundaryCooldown:
		return
	isBoundaryCooldown = true
	isRespawning = true
	puzzleLogic.tryDirection(DarkRoomPuzzleLogic.Direction.UP)

func onBoundaryDown(body: Node2D) -> void:
	if not body is PlayerController or isBoundaryCooldown:
		return
	isBoundaryCooldown = true
	isRespawning = true
	puzzleLogic.tryDirection(DarkRoomPuzzleLogic.Direction.DOWN)

func onStepCorrect() -> void:
	sendPlayerToMarker("Start")

func onFirstMistake() -> void:
	sendPlayerToMarker("Start")

func onSecondMistake() -> void:
	isRespawning = false
	LevelContainer.bedroomLevel.sendPlayerToMarker("Start")

func onPuzzleSolved() -> void:
	print("Solved")
	sendPlayerToMarker("Start")
