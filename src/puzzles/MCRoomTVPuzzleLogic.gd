class_name MCRoomTVPuzzleLogic
extends Resource

var cartridgesCases: Array[CartridgeItem]
var correctCartridgeSequence: Array[CartridgeItem.CartridgeGenre]
var focusedSlot: int;

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

func initPuzzle() -> void:
	Dialogic.timeline_ended.connect(checkPuzzleSolved)

func tryToPutCartridgeItem(cartridgeItem: CartridgeItem) -> bool:
	print("tryToPutCartridgeItem", cartridgeItem)
	if(cartridgesCases.get(focusedSlot)):
		return false;
	addCartridgeItem(cartridgeItem);
	return true;

func addCartridgeItem(cartridgeItem: CartridgeItem):
	addCartridgeItemToSlot(focusedSlot, cartridgeItem);
	pass

func addCartridgeItemToSlot(slot: int, cartridgeItem: CartridgeItem):
	MainEventBus.inventory_remove_item.emit(cartridgeItem);
	cartridgesCases.set(slot, cartridgeItem);
	pass

func isPuzzleCorrect() -> bool:
	for i in cartridgesCases.size():
		var cartridge = cartridgesCases[i];
		if(!cartridge):
			return false;
		var expectedGenre = correctCartridgeSequence[i]
		if(cartridge.cartridgeGenre == expectedGenre):
			return true;
		if(cartridge.cartridgeGenre != expectedGenre):
			return false;
	return true;

func setFocusedPuzzle(slot: int):
	focusedSlot = slot;

func getCartridgeInSlot(slot: int) -> CartridgeItem:
	return cartridgesCases.get(slot);
	
func removeCartridgeFromSlot(slot: int):
	cartridgesCases[slot] = null;

func checkPuzzleSolved():
	if(isPuzzleCorrect()):
		triggerPuzzleSolved();

func triggerPuzzleSolved():
	Dialogic.timeline_ended.disconnect(checkPuzzleSolved)
	Dialogic.start('MCRoomTVPuzzleSolved');
	MainEventBus.puzzle_2_solved.emit()
