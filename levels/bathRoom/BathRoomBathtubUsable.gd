extends Usable

@onready var curtains1Sprite: Sprite2D = $Curtains1Sprite;
@onready var curtains2Sprite: Sprite2D = $Curtains2Sprite;
@onready var dollSprite: Sprite2D = $DollSprite;

var isOpened: bool = false;
var isDollTaken: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func useObject():
	if(isDollTaken):
		Dialogic.start("BathroomBathtubUse", "DollTaken");
	elif(isOpened):
		Dialogic.start("BathroomBathtubUse", "CurtainsOpened");
		isDollTaken = true;
		dollSprite.visible = false;
		MainEventBus.inventory_add_item.emit(BathroomDollItem.new());
	else:
		Dialogic.signal_event.connect(_signal_event_triggered);
		Dialogic.start("BathroomBathtubUse", "CurtainsClosed");
		isOpened = true;
		pass;

func openCurtains():
	curtains1Sprite.visible = false;
	curtains2Sprite.visible = true;
	dollSprite.visible = true;
	
func _signal_event_triggered(arg: String):
	if(arg == "Bathroom_BathtubCurtainsOpen"):
		Dialogic.signal_event.disconnect(_signal_event_triggered);
		openCurtains();
