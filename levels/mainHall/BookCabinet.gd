extends Usable

@export var image: Texture2D

func useObject():
	Dialogic.start('MainHallCabinetPhoto');
	get_viewport().set_input_as_handled();
