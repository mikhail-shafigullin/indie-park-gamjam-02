class_name BathRoomChair
extends Usable

var isPuzzleAvailable = false;
var isDollPlaced = false;
var isHeadPlaced = false;
var isClothesPlaced = false;

@onready var nakedDollSprite = $NakedDollSprite;
@onready var clothedDollSprite = $ClothedDollSprite;
@onready var headSprite = $HeadSprite;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_event)
	pass # Replace with function body.

func useObject():
	checkPuzzleAvailable()
	if(isPuzzleAvailable):
		Dialogic.start("BathroomChairAssemble", "chairUseWithPuzzle");
		return;
	if(!isDollPlaced):
		Dialogic.start("BathroomChairAssemble", "chairUseWithoutDoll");
		return;
	if(isDollPlaced):
		Dialogic.start("BathroomChairAssemble", "chairUseWithDoll");
		return;
	

func checkPuzzleAvailable():
	isPuzzleAvailable =  isDollPlaced and isHeadPlaced and isClothesPlaced;

func _on_dialogic_event(atr: String):
	if(atr == "Bathroom_DollPlacedOnChair"):
		nakedDollSprite.visible = true;
		isDollPlaced = true;
	if(atr == "Bathroom_HeadPlacedOnChair"):
		headSprite.visible = true;
		isHeadPlaced = true;
	if(atr == "Bathroom_ClothesPlacedOnChair"):
		nakedDollSprite.visible = false;
		clothedDollSprite.visible = true;
		isClothesPlaced = true;
