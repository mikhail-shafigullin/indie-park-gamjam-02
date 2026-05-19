extends Usable

@onready var openedSprite: Sprite2D = $OpenedSprite;
@onready var headSprite: Sprite2D = $HeadSprite;
@onready var closedSprite: Sprite2D = $ClosedSprite;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func useObject():
	openToilet()

func openToilet():
	closedSprite.visible = false;
	openedSprite.visible = true;
	headSprite.visible = true;
