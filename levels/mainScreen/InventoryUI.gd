extends Control

const PANEL_WIDTH: float = 250.0
const ANIM_DURATION: float = 0.3

enum NavMode { ITEMS, TOOLTIP }

var isOpen: bool = false
var navMode: NavMode = NavMode.ITEMS
var items: Array[InventoryItem] = []
var focusedItemIndex: int = 0
var tooltipFocusedIndex: int = 0
var isEnabled: bool = true;

@onready var inventoryPanel: Panel = %InventoryPanel
@onready var itemListContainer: VBoxContainer = %ItemListContainer
@onready var itemNameLabel: Label = %ItemNameLabel
@onready var itemDescLabel: Label = %ItemDescLabel
@onready var tooltipPanel: Panel = %TooltipPanel
@onready var tooltipUseLabel: Label = %TooltipUseLabel
@onready var tooltipExamineLabel: Label = %TooltipExamineLabel

func _ready() -> void:
	inventoryPanel.position.x = -PANEL_WIDTH
	visible = false
	tooltipPanel.visible = false
	MainEventBus.inventory_add_item.connect(addItem);
	MainEventBus.inventory_remove_item.connect(removeItem);
	Dialogic.timeline_started.connect(disableInventory);
	Dialogic.timeline_ended.connect(enableInventory)

func _input(event: InputEvent) -> void:
	if (event is InputEventKey and event.pressed and 
		not event.echo and event.keycode == KEY_TAB and isEnabled):
		toggleInventory()
		get_viewport().set_input_as_handled()
		return

	if not isOpen:
		return

	if event.is_action_pressed("move_down"):
		handleMoveDown()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_up"):
		handleMoveUp()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("use"):
		handleUse()
		get_viewport().set_input_as_handled()

func handleMoveDown() -> void:
	if items.is_empty():
		return
	if navMode == NavMode.ITEMS:
		focusedItemIndex = (focusedItemIndex + 1) % items.size()
		updateItemFocus()
	else:
		tooltipFocusedIndex = (tooltipFocusedIndex + 1) % 2
		updateTooltipFocus()

func handleMoveUp() -> void:
	if items.is_empty():
		return
	if navMode == NavMode.ITEMS:
		focusedItemIndex = (focusedItemIndex - 1 + items.size()) % items.size()
		updateItemFocus()
	else:
		tooltipFocusedIndex = (tooltipFocusedIndex - 1 + 2) % 2
		updateTooltipFocus()

func handleUse() -> void:
	if items.is_empty():
		return
	if navMode == NavMode.ITEMS:
		showTooltip()
	else:
		executeTooltipAction()
		hideTooltip()

func showTooltip() -> void:
	navMode = NavMode.TOOLTIP
	tooltipFocusedIndex = 0
	tooltipPanel.visible = true
	updateTooltipFocus()

func hideTooltip() -> void:
	navMode = NavMode.ITEMS
	tooltipPanel.visible = false

func executeTooltipAction() -> void:
	var item = items[focusedItemIndex]
	if tooltipFocusedIndex == 0:
		item.useWithSignal()
	else:
		item.examineWithSignal()
	hideTooltip();
	closeInventoryEffect();

func disableInventory():
	isEnabled = false;
	closeInventoryEffect();
	
func enableInventory():
	isEnabled = true;

func updateItemFocus() -> void:
	for i in items.size():
		var btn = itemListContainer.get_child(i) as Button
		if btn:
			btn.text = ("> " if i == focusedItemIndex else "  ") + items[i].itemName
	var focused = items[focusedItemIndex]
	itemNameLabel.text = focused.itemName
	itemDescLabel.text = focused.description

func updateTooltipFocus() -> void:
	tooltipUseLabel.text = ("> " if tooltipFocusedIndex == 0 else "  ") + "Use"
	tooltipExamineLabel.text = ("> " if tooltipFocusedIndex == 1 else "  ") + "Examine"

func addItem(item: InventoryItem) -> void:
	items.append(item)
	var button = Button.new()
	button.text = "  " + item.itemName
	button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.focus_mode = Control.FOCUS_NONE
	button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	itemListContainer.add_child(button)
	if items.size() == 1:
		updateItemFocus()

func removeItem(item: InventoryItem) -> void:
	var idx = items.find(item)
	if idx == -1:
		return
	items.remove_at(idx)
	itemListContainer.get_child(idx).queue_free()
	if items.is_empty():
		itemNameLabel.text = ""
		itemDescLabel.text = ""
	else:
		focusedItemIndex = clamp(focusedItemIndex, 0, items.size() - 1)
		updateItemFocus()

func toggleInventory() -> void:
	if isOpen:
		closeInventory()
	else:
		openInventory()

func openInventory() -> void:
	isOpen = true
	visible = true
	hideTooltip()
	if not items.is_empty():
		focusedItemIndex = 0
		updateItemFocus()
	MainEventBus.inventory_opened.emit()
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(inventoryPanel, "position:x", 0.0, ANIM_DURATION)

func closeInventory() -> void:
	MainEventBus.inventory_closed.emit()
	closeInventoryEffect()

func closeInventoryEffect() -> void:
	isOpen = false
	hideTooltip()
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(inventoryPanel, "position:x", -PANEL_WIDTH, ANIM_DURATION)
	tween.tween_callback(func(): visible = false)
