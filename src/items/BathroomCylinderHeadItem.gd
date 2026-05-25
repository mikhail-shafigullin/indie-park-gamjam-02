class_name BathroomCylinderHeadItem
extends InventoryItem


func _init() -> void:
	itemName = "Cylinder"
	description = "Strange cylinder that I found in the toilet"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func use(usedOnItem: Usable) -> void:
	if usedOnItem is BathRoomChair:
		var bathRoomChair = usedOnItem as BathRoomChair;
		if(bathRoomChair.isDollPlaced):
			Dialogic.start("BathroomChairAssemble", "placeHead");
			MainEventBus.inventory_remove_item.emit(self);
		else:
			Dialogic.start("DefaultMessages", "inventoryItemNoUse")
	else:
		Dialogic.start("DefaultMessages", "inventoryItemNoUse")
