class_name ImageLayerContainer 
extends Control

@onready var textureRect: TextureRect = %TextureRect

signal image_layer_set_image(image: Texture2D);
signal image_layer_image_is_updated();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image_layer_set_image.connect(setImage)
	set_process_input(false);

func setImage(image: Texture2D) -> void:
	textureRect.texture = image;
	image_layer_image_is_updated.emit();

func showImageLayer() -> void:
	self.visible = true;
	MainEventBus.image_layer_showed.emit();

func hideImageLayer() -> void:
	self.visible = false;
	
func startImageView() -> void:
	set_process_input(true)

func closeImageView() -> void:
	set_process_input(false)
	MainEventBus.image_layer_exit.emit();

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		closeImageView()
