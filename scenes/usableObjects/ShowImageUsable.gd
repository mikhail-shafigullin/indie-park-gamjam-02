extends Usable

@export var image: Texture2D

func useObject(): 
	MainEventBus.puzzle_layer_show_scene.emit(image)
