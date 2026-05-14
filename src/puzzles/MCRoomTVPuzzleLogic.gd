extends Resource

var cartridgesCases: Array[CartridgeItem]
var correctCartridgeSequence: Array[CartridgeItem.CartridgeGenre]

func _init() -> void:
	cartridgesCases.resize(6);
	correctCartridgeSequence = [
		CartridgeItem.CartridgeGenre.PUZZLE,
		CartridgeItem.CartridgeGenre.FIGHTING,
		CartridgeItem.CartridgeGenre.ROLEPLAY,
		CartridgeItem.CartridgeGenre.PLATFORMER,
		CartridgeItem.CartridgeGenre.RACING,
		CartridgeItem.CartridgeGenre.ADVENTURE
	];

func addCartridgeItem(slot: int, cartridgeItem: CartridgeItem):
	cartridgesCases.set(slot, cartridgeItem);
	pass

func isPuzzleCorrect() -> bool:
	for i in cartridgesCases.size():
		var cartridge = cartridgesCases[i];
		if(!cartridge):
			return false;
		var expectedGenre = correctCartridgeSequence[i]
		if(cartridge.cartridgeGenre != expectedGenre):
			return false;
	return true;
