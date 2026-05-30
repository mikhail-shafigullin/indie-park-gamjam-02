class_name BathroomNewspaper
extends InventoryItem

func _init() -> void:
	itemName = "Newspaper Clipping";
	description = "Clipping that I found in the bathroom"

func use(usedOnItem: Usable) -> void:
	examine();

func examine() -> void:
	Dialogic.start("BathroomMirror", "newspaperNoteExamine")
