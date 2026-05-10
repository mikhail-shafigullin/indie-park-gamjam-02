class_name ApartmentDoor
extends Usable

@onready var image: Sprite2D = %Image;
@onready var staticBody: StaticBody2D = %StaticBody2D;

@export_enum("purple", "red", "blue") var dialogueColor: String;

func useObject():
	Dialogic.VAR.set_variable("door_color", dialogueColor)
	Dialogic.start('MainHallDoorClosed');
	pass;

func open():
	image.visible = false;
	staticBody.collision_layer &= ~(1 << 1 | 1 << 2);

func close():
	image.visible = true;
	staticBody.collision_layer |= (1 << 1 | 1 << 2);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
