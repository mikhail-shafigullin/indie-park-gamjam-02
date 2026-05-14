extends Usable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func useObject():
	Dialogic.VAR.set_variable("mcRoom.isCartridgeInTVStand", true)
	Dialogic.start('MCRoomTVUseWithoutCartridge');
