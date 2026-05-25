class_name BathroomClothesItem
extends InventoryItem

func _init() -> void:
	itemName = "Clothes"
	description = "A pile of clothes that fell out of the bathroom closet"
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func use(usedOnItem: Usable) -> void:
	if usedOnItem is BathRoomChair:
		var bathRoomChair = usedOnItem as BathRoomChair;
		if(bathRoomChair.isDollPlaced):
			Dialogic.start("BathroomChairAssemble", "placeClothes");
			MainEventBus.inventory_remove_item.emit(self);
		else:
			Dialogic.start("DefaultMessages", "inventoryItemNoUse")
	else:
		Dialogic.start("DefaultMessages", "inventoryItemNoUse")
