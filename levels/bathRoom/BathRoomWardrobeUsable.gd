extends Usable

var isOpened: bool;

@onready var collision: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var wardrobeClosedSprite: Sprite2D = $WardrobeClosedSprite;
@onready var wardrobeOpenedSprite: Sprite2D = $WardrobeOpenedSprite;

@export var clothesNode: Node2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func useObject():
	if(isOpened):
		Dialogic.start("BathroomWardrobeOpened", "wardrobeIsOpened");
		return;
	isOpened = true;
	Dialogic.start("BathroomWardrobeOpened", "wardrobeIsClosed");
	Dialogic.signal_event.connect(_on_dialogic_signal, CONNECT_ONE_SHOT)

func openWardrobe():
	wardrobeClosedSprite.visible = false;
	wardrobeOpenedSprite.visible = true;
	if(clothesNode.has_method("showClothes")):
		clothesNode.showClothes(true);
	
func _on_dialogic_signal(argument: String):
	if(argument == "Bathroom_ClothesFallsOut"):
		openWardrobe()
