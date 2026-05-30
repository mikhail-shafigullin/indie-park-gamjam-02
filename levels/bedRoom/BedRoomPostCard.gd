extends Usable

var isFirstUse: bool = true
@onready var sprite: Sprite2D = $Sprite2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func useObject():
	if isFirstUse:
		Dialogic.signal_event.connect(on_signal_event, CONNECT_ONE_SHOT);
		isFirstUse = false;
		Dialogic.start("BedroomMirror", "withPostcard")
		MainEventBus.inventory_add_item.emit(BedroomPostcardItem.new())
	else: 
		Dialogic.start("BedroomMirror", "withoutPostcard")

func on_signal_event(arg: String):
	if arg == 'Bedroom_postcardTake':
		sprite.visible = false
