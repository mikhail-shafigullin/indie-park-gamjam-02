class_name InventoryItem
extends Resource

@export var itemName: String = ""
@export var description: String = ""

func useWithSignal() -> void:
	use(Global.player.hoveredUsable);
	MainEventBus.inventory_item_used.emit(self)

func examineWithSignal() -> void:
	examine();
	MainEventBus.inventory_item_examined.emit(self)

func use(usedOnItem: Usable) -> void:
	pass;

func examine() -> void:
	pass
