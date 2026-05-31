extends Usable

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D;
@onready var tiedPoleSprite: Sprite2D = $TiedPole/TiedPoleSprite;
@onready var untiedPoleSprite: Sprite2D = $TiedPole/UntiedPoleSprite;

var isVisible: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSprite.play()
	pass # Replace with function body.

func useObject():
	Dialogic.start("BedroomBoatEvents", "boatUsed")

func hideBoat():
	isVisible = false;
	animatedSprite.visible = false;
	tiedPoleSprite.visible = false;
	untiedPoleSprite.visible = true;
	
func showBoat():
	isVisible = true;
	animatedSprite.visible = true;
	tiedPoleSprite.visible = true;
	untiedPoleSprite.visible = false;
