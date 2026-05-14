class_name DollItem
extends InventoryItem

func _init() -> void:
	itemName = "Doll"
	description = "A worn cloth doll with button eyes. It's looking at you."

func use(usedOnItem: Usable) -> void:
	print("Shaking the doll...")

func examine() -> void:
	print("Examining the doll. One eye is stitched slightly crooked.")
