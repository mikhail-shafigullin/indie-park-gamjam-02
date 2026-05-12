class_name InventoryItem
extends Resource

@export var itemName: String = ""
@export var description: String = ""

func useWithSignal() -> void:
	MainEventBus.inventory_item_used.emit(self)
	use(Global.player.hoveredUsable);

func examineWithSignal() -> void:
	MainEventBus.inventory_item_examined.emit(self)
	examine();

func use(usedOnItem: Usable) -> void:
	pass;

func examine() -> void:
	pass
