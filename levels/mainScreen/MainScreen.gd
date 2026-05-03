extends Node2D

@export var starterScene: PackedScene

@onready var locationNode: Node = %Location;
@onready var fadeInFadeOut: FadeInFadeOut = %FadeInFadeOut;
@onready var imageLayer: ImageLayerContainer = %ImageLayer;

var currentLocation: PackedScene;

func _ready() -> void:
	setLocation(starterScene);
	MainEventBus.image_layer_show_image.connect(turnOnImageLayer);
	MainEventBus.image_layer_exit.connect(turnOffImageLayer)
	
func setLocation(location: PackedScene):
	currentLocation = location;
	for child: Node in locationNode.get_children():
		child.queue_free();
	var locationScene = currentLocation.instantiate();
	locationNode.add_child(locationScene);
	MainEventBus.level_changed.emit()

func turnOnImageLayer(image: Texture2D):
	fadeInFadeOut.animation_fade_in_to_object.emit(self);
	fadeInFadeOut.animation_fade_in_finished.connect(
		showImageAndStartFadeOut, 
		CONNECT_ONE_SHOT
		)
	imageLayer.image_layer_set_image.emit(image);
	pass;

func turnOffImageLayer():
	fadeInFadeOut.animation_fade_in_to_object.emit(self);
	fadeInFadeOut.animation_fade_in_finished.connect(
		hideImageAndSyatyFadeOut, 
		CONNECT_ONE_SHOT
		)
	pass;

func showImageAndStartFadeOut():
	imageLayer.showImageLayer()
	fadeInFadeOut.animation_fade_out_from_object.emit(self);
	fadeInFadeOut.animation_fade_out_finished.connect(
		func(): imageLayer.startImageView(),
		CONNECT_ONE_SHOT
	)
	pass

func hideImageAndSyatyFadeOut():
	imageLayer.hideImageLayer();
	fadeInFadeOut.animation_fade_out_from_object.emit(self);
	fadeInFadeOut.animation_fade_out_finished.connect(
		func(): MainEventBus.image_layer_hidden.emit(),
		CONNECT_ONE_SHOT
	)
