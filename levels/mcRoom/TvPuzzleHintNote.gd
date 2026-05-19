extends Usable

@onready var collision = $StaticBody2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	pass # Replace with function body.

func useObject():
	Dialogic.start("MCRoomNoteOnTheBed")
	MainEventBus.inventory_add_item.emit(MCRoomNoteItem.new());
	
func _on_dialogic_signal(argument:String):
	if argument == "MCRoom_DeleteNoteFromFloor":
		Dialogic.signal_event.disconnect(_on_dialogic_signal);
		collision.set_deferred("disabled",true)
		visible = false;
