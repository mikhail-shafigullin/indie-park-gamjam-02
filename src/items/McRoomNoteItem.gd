class_name MCRoomNoteItem
extends InventoryItem

func _init() -> void:
	itemName = "Diary Note"
	description = "Old entries I wrote in my diary"

func use(usedOnItem: Usable) -> void:
	examine();

func examine() -> void:
	Dialogic.start("MCRoomNoteDescription")
