extends Usable

@onready var openedSprite: Sprite2D = $OpenedSprite;
@onready var headSprite: Sprite2D = $HeadSprite;
@onready var closedSprite: Sprite2D = $ClosedSprite;

var isOpened = false;
var isHeadTaken = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func useObject():
	if(isHeadTaken):
		Dialogic.start("BathroomToiletUse", "HeadTaken");
	elif(isOpened):
		Dialogic.start("BathroomToiletUse", "ToiletOpened");
		headSprite.visible = false;
		isHeadTaken = true;
		MainEventBus.inventory_add_item.emit(BathroomCylinderHeadItem.new());
	else:
		Dialogic.signal_event.connect(_signal_event_triggered);
		Dialogic.start("BathroomToiletUse", "ToiletClosed");
		isOpened = true;

func openToilet():
	closedSprite.visible = false;
	openedSprite.visible = true;
	headSprite.visible = true;
	
func _signal_event_triggered(arg: String):
	if(arg == "Bathroom_ToiletOpen"):
		Dialogic.signal_event.disconnect(_signal_event_triggered)
		openToilet()
