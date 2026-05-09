extends Usable

@export var image: Texture2D

func useObject():
	MainEventBus.image_layer_show_image.emit(image)
