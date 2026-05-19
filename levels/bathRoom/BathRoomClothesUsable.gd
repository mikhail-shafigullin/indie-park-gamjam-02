extends Usable

@onready var collision: CollisionShape2D = $StaticBody2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	showClothes(false);
	pass # Replace with function body.

func useObject():
	Dialogic.signal_event.connect(_on_signal_event);
	Dialogic.start("BathroomClothesOnGround");
	MainEventBus.inventory_add_item.emit(BathroomClothesItem.new());
	pass;

func showClothes(show: bool):
	collision.set_deferred("disabled", !show)
	visible = show;

func _on_signal_event(arg: String):
	if(arg == "Bathroom_ClothesOnTheGround"):
		showClothes(false)
		Dialogic.signal_event.disconnect(_on_signal_event);
		
