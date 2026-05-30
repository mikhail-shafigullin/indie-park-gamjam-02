class_name MCRoomPhoto
extends InventoryItem

func _init() -> void:
	itemName = "Photo from my room"
	description = "Photo that I found in my room"

func use(usedOnItem: Usable) -> void:
	examine();

func examine() -> void:
	Dialogic.start("MCRoomTVPuzzleSolved", "photoExamine");
