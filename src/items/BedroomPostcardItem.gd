class_name BedroomPostcardItem
extends InventoryItem

func _init() -> void:
	itemName = "Postcard";
	description = "Postcard that I found in mom's bedroom";

func use(usedOnItem: Usable) -> void:
	examine();

func examine():
	Dialogic.start("BedroomMirror", "postcardItem");
