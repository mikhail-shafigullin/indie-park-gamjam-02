extends Usable

@onready var collision: CollisionShape2D = $StaticBody2D/CollisionShape2D;
var isPhotoCorrect: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	showPhoto(false);
	PuzzleStates.bathroomDollPuzzleLogic.takeCorrectPhoto.connect(createCorrectPhoto)
	PuzzleStates.bathroomDollPuzzleLogic.takeIncorrectPhoto.connect(createIncorrectPhoto)
	pass # Replace with function body.

func useObject():
	if(isPhotoCorrect):
		Dialogic.start("BathroomPhotocameraUse", "correctPhoto");
	else:
		Dialogic.start("BathroomPhotocameraUse", "incorrectPhoto");

func createCorrectPhoto():
	showPhoto(true);
	isPhotoCorrect = true;
	pass;
	
func createIncorrectPhoto():
	showPhoto(true)
	isPhotoCorrect = false;
	pass;

func showPhoto(show: bool):
	collision.set_deferred("disabled", !show)
	visible = show;
