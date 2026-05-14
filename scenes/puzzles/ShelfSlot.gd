class_name ShelfSlot
extends Panel

@onready var label: RichTextLabel

signal slotActivated(slot: ShelfSlot)

var slotIndex: int = 0

func _ready() -> void:
	add_theme_stylebox_override("panel", StyleBoxEmpty.new())
	focus_mode = Control.FOCUS_ALL
	mouse_filter = Control.MOUSE_FILTER_STOP
	focus_entered.connect(onFocusChanged)
	focus_exited.connect(onFocusChanged)
	mouse_entered.connect(onMouseEntered)

func onFocusChanged() -> void:
	queue_redraw()

func onMouseEntered() -> void:
	grab_focus()

func _draw() -> void:
	if has_focus():
		draw_rect(Rect2(Vector2.ZERO, size), Color.WHITE, false, 2.0)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			slotActivated.emit(self)
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed("use"):
		slotActivated.emit(self)
		get_viewport().set_input_as_handled()
