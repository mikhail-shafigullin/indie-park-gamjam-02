class_name BedroomCertificateItem
extends InventoryItem

func _init() -> void:
	itemName = "Sister's Certificate";
	description = "Sister's certificate that I found in mom's bedroom";

func use(usedOnItem: Usable) -> void:
	examine();

func examine():
	Dialogic.start("BedroomMirror", "postcardItem");
