class_name BathroomPhoto
extends InventoryItem

func _init() -> void:
	itemName = "Photo from the bathroom";
	description = "Photo how we played chairs";

func use(usedOnItem: Usable) -> void:
	examine();

func examine():
	Dialogic.start("BathroomPhotocameraUse", "photoExamine");
