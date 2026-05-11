extends Usable

@onready var collision: CollisionShape2D = %CollisionShape2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	pass # Replace with function body.

func useObject():
	Dialogic.start('MCRoomCartridgeOnFloor');
	MainEventBus.inventory_add_item.emit(
		CartridgeItem.new(CartridgeItem.CartrigdeGenre.FIGHTING)
		);
	MainEventBus.inventory_add_item.emit(
		CartridgeItem.new(CartridgeItem.CartrigdeGenre.RACING)
		);
	MainEventBus.inventory_add_item.emit(
		CartridgeItem.new(CartridgeItem.CartrigdeGenre.ADVENTURE)
		);
	MainEventBus.inventory_add_item.emit(
		CartridgeItem.new(CartridgeItem.CartrigdeGenre.PLATFORMER)
		);
	MainEventBus.inventory_add_item.emit(
		CartridgeItem.new(CartridgeItem.CartrigdeGenre.PUZZLE)
		);
	MainEventBus.inventory_add_item.emit(
		CartridgeItem.new(CartridgeItem.CartrigdeGenre.ROLEPLAY));
	pass;

func _on_dialogic_signal(argument:String):
	if argument == "MCRoom_DeleteCartridgesFromFloor":
		Dialogic.signal_event.disconnect(_on_dialogic_signal);
		collision.set_deferred("disabled",true)
		visible = false;
