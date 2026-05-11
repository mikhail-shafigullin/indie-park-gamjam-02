class_name CartridgeItem
extends InventoryItem

var cartridgeGenre: CartrigdeGenre;

enum CartrigdeGenre{
	FIGHTING,
	RACING,
	ADVENTURE,
	PLATFORMER,
	PUZZLE,
	ROLEPLAY
}

func _init(genre: CartrigdeGenre) -> void:
	cartridgeGenre = genre;
	match genre:
		CartrigdeGenre.FIGHTING:
			itemName = "Cartridge #1"
		CartrigdeGenre.RACING:
			itemName = "Cartridge #2"
		CartrigdeGenre.ADVENTURE:
			itemName = "Cartridge #3"
		CartrigdeGenre.PLATFORMER:
			itemName = "Cartridge #4"
		CartrigdeGenre.PUZZLE:
			itemName = "Cartridge #5"
		CartrigdeGenre.ROLEPLAY:
			itemName = "Cartridge #6"
	description = "Cartridge for MES console"

func use() -> void:
	print("Inserting the cartridge...")

func examine() -> void:
	print("Examining the cartridge. Looks like something retro.")
