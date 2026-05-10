extends Control

@onready var grabLabel: Label = %GrabLabel;
@onready var useLabel: Label = %UseLabel;
@onready var rotateLabel: Label = %RotateLabel;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainEventBus.grabable_object_is_hovered.connect(func(_ignore): grabEnabled(true))
	MainEventBus.grabable_object_is_unhovered.connect(func(_ignore): grabEnabled(false))
	MainEventBus.usable_object_is_hovered.connect(func(_ignore): useEnabled(true))
	MainEventBus.usable_object_is_unhovered.connect(func(_ignore): useEnabled(false))
	MainEventBus.grabable_object_grabbed.connect(
		func(grabable: Node2D): 
			useEnabled(false);
			if(grabable.has_node("RotatableComponent")):
				rotateEnabled(true);
	)
	MainEventBus.grabable_object_released.connect(func(_ignore): rotateEnabled(false));
	pass # Replace with function body.

func grabEnabled(isEnabled: bool) -> void:
	grabLabel.visible = isEnabled;

func useEnabled(isEnabled: bool) -> void:
	useLabel.visible = isEnabled;

func rotateEnabled(isEnabled: bool) -> void:
	rotateLabel.visible = isEnabled;
