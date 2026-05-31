extends Node

func _ready() -> void:
	MainEventBus.usable_object_used.connect(trackObjectUsed);
	MainEventBus.inventory_item_used.connect(trackInventoryObjectUsed)
	MainEventBus.inventory_item_examined.connect(trackInventoryObjectExamined)
	MainEventBus.puzzle_1_1_solved.connect(func(): trackPuzzleSolved("puzzle 1.1"))
	MainEventBus.puzzle_1_2_solved.connect(func(): trackPuzzleSolved("puzzle 1.2"))
	MainEventBus.puzzle_1_3_solved.connect(func(): trackPuzzleSolved("puzzle 1.3"))
	MainEventBus.puzzle_2_solved.connect(func(): trackPuzzleSolved("puzzle 2"))
	MainEventBus.puzzle_3_solved.connect(func(): trackPuzzleSolved("puzzle 3"))
	MainEventBus.puzzle_4_solved.connect(func(): trackPuzzleSolved("puzzle 4"))
	Dialogic.timeline_started.connect(trackDialogueStarted)

func trackTeleportPlayer(): 
	Analytics.track_event("teleportPlayer")

func trackObjectUsed(node: Node2D):
	Analytics.track_event("objectUsed", {
		"usable": node.get_path() if node else "",
		"level": LevelContainer.currentLevel.get_path() if LevelContainer.currentLevel else ""
	})

func trackInventoryObjectUsed(item: InventoryItem):
	Analytics.track_event("inventoryItemUsed", {
		"name": item.itemName if item else "",
		"level": LevelContainer.currentLevel.get_path() if LevelContainer.currentLevel else ""
	})
	
func trackInventoryObjectExamined(item: InventoryItem):
	Analytics.track_event("inventoryItemExamined", {
		"name": item.itemName if item else "",
		"level": LevelContainer.currentLevel.get_path() if LevelContainer.currentLevel else ""
	})

func trackPuzzleSolved(puzzleName: String):
	Analytics.track_event("puzzleSolved", {
		"name": puzzleName,
		"level": LevelContainer.currentLevel.get_path() if LevelContainer.currentLevel else ""
	})

func trackDialogueStarted():
	Analytics.track_event("dialogueStarted", {
		"name": Dialogic.current_timeline,
		"level": LevelContainer.currentLevel.get_path() if LevelContainer.currentLevel else ""
	})
