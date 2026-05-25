class_name BathroomDollItem
extends InventoryItem


func _init() -> void:
	itemName = "Naked Mannequin"
	description = "Mannedquin that I found in the bathtub"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func use(usedOnItem: Usable) -> void:
	if usedOnItem is BathRoomChair:
		var bathRoomChair = usedOnItem as BathRoomChair;
		Dialogic.start("BathroomChairAssemble", "placeDoll");
		MainEventBus.inventory_remove_item.emit(self);
	else:
		Dialogic.start("DefaultMessages", "inventoryItemNoUse")
