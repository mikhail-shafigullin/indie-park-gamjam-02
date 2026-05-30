extends Usable

@onready var sprite: Sprite2D = $Sprite2D
var isFirstUser: bool = true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func useObject():
	if(isFirstUser):
		Dialogic.signal_event.connect(on_signal_event, CONNECT_ONE_SHOT);
		Dialogic.start("BedroomItemsUse", "CertificateTake");
		isFirstUser = false;
		MainEventBus.inventory_add_item.emit(BedroomCertificateItem.new())
	else:
		Dialogic.start("DefaultMessages", "itemIsAlreadyUsed");

func on_signal_event(arg: String):
	if arg == 'Bedroom_cerfiticateTake':
		sprite.visible = false
