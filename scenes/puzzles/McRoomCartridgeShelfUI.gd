class_name McRoomCartridgeShelfUI
extends Control

signal slotSelected(slotIndex: int)

var COLS: int;

var slots: Array[ShelfSlot] = []
var focusedSlotIndex: int = 0

@onready var slotGrid: GridContainer = %SlotGrid

func _ready() -> void:
	COLS = slotGrid.columns;
	for child in slotGrid.get_children():
		if child is ShelfSlot:
			var idx = slots.size()
			child.slotIndex = idx
			child.slotActivated.connect(onSlotActivated)
			child.focus_entered.connect(onSlotFocusEntered.bind(idx))
			slots.append(child)
	focusedSlotIndex = 0;
	slots[0].grab_focus()

func _input(event: InputEvent) -> void:
	if slots.is_empty():
		return
	if event.is_action_pressed("move_right"):
		moveFocus(1, 0)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_left"):
		moveFocus(-1, 0)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_down"):
		moveFocus(0, 1)
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_up"):
		moveFocus(0, -1)
		get_viewport().set_input_as_handled()

func onSlotFocusEntered(idx: int) -> void:
	focusedSlotIndex = idx
	PuzzleStates.mcRoomTVPuzzleLogic.setFocusedPuzzle(idx);

func moveFocus(dx: int, dy: int) -> void:
	var rows: int = slots.size() / COLS
	var row: int = focusedSlotIndex / COLS
	var col: int = focusedSlotIndex % COLS
	col = (col + dx + COLS) % COLS
	row = (row + dy + rows) % rows
	focusedSlotIndex = row * COLS + col
	slots[focusedSlotIndex].grab_focus()

func onSlotActivated(slot: ShelfSlot) -> void:
	var cartridgeInSlot: CartridgeItem = PuzzleStates.mcRoomTVPuzzleLogic.getCartridgeInSlot(slot.slotIndex);
	if(cartridgeInSlot):
		Dialogic.VAR.set_variable("mcRoom.cartridgeType", cartridgeInSlot.cartridgeGenre);
		Dialogic.VAR.set_variable("mcRoom.isCartridgeInserted", true);
		PuzzleStates.mcRoomTVPuzzleLogic.removeCartridgeFromSlot(slot.slotIndex);
		MainEventBus.inventory_add_item.emit(cartridgeInSlot);
	else:
		Dialogic.VAR.set_variable("mcRoom.isCartridgeInserted", false);
	
	Dialogic.start("MCRoomTVPuzzleExtractCartridge");
	slotSelected.emit(slot.slotIndex)
	
