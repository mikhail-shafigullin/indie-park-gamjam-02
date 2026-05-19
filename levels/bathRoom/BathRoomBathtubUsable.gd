extends Usable

@onready var curtains1Sprite: Sprite2D = $Curtains1Sprite;
@onready var curtains2Sprite: Sprite2D = $Curtains2Sprite;
@onready var dollSprite: Sprite2D = $DollSprite;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func useObject():
	openCurtains();
	pass;

func openCurtains():
	curtains1Sprite.visible = false;
	curtains2Sprite.visible = true;
	dollSprite.visible = true;
	
