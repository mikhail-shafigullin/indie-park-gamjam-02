class_name CartridgeItem
extends InventoryItem

var cartridgeGenre: CartridgeGenre;

enum CartridgeGenre{
	FIGHTING,
	RACING,
	ADVENTURE,
	PLATFORMER,
	PUZZLE,
	ROLEPLAY
}

func _init(genre: CartridgeGenre) -> void:
	cartridgeGenre = genre;
	match genre:
		CartridgeGenre.FIGHTING:
			itemName = "Cartridge with a mighty kick"
		CartridgeGenre.RACING:
			itemName = "Cartridge with a red car"
		CartridgeGenre.ADVENTURE:
			itemName = "Cartridge with a person holding a torch"
		CartridgeGenre.PLATFORMER:
			itemName = "Cartridge with a cute fox"
		CartridgeGenre.PUZZLE:
			itemName = "Cartridge with some nerd"
		CartridgeGenre.ROLEPLAY:
			itemName = "Cartridge with green hair"
	description = "Cartridge for MES console"

func use(usedOnItem: Usable) -> void:
	if(usedOnItem and usedOnItem.name == "McRoomTV"):
		Dialogic.start('MCRoomTVUseWithCartridge');
	else:
		Dialogic.start('MCRoomCartridgeUseNoItem');

func examine() -> void:
	Dialogic.VAR.set_variable("mcRoom.cartridgeType", cartridgeGenre)
	Dialogic.start('MCRoomCartridge1Examine');
