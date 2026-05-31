extends Usable

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D;

var isVisible: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSprite.play()
	pass # Replace with function body.

func useObject():
	if(not Dialogic.signal_event.is_connected(onDialogicEvent)):
		Dialogic.signal_event.connect(onDialogicEvent, CONNECT_ONE_SHOT);
	Dialogic.start("BedroomBoatEvents", "boatBedroom2Used")

func onDialogicEvent(arg: String):
	if arg == "Bedroom_BoatMoveBackToTheBedroom":
		LevelContainer.bedroomLevel.sendPlayerToMarker("Start")
		Global.player.changeSpriteOnBoatStateTo(false)

func hideBoat():
	isVisible = false;
	animatedSprite.visible = false;
	
func showBoat():
	isVisible = true;
	animatedSprite.visible = true;
