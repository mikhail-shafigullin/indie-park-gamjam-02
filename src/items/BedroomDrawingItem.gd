class_name BedroomDrawingItem
extends InventoryItem

func _init() -> void:
	itemName = "My drawings";
	description = "My childhood drawings...";

func use(usedOnItem: Usable) -> void:
	examine();

func examine():
	Dialogic.start("BedroomItemsUse", "DrawingUse");
