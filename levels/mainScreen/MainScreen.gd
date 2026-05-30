class_name MainScreen
extends Node2D

@export_enum("Debug", "MainRoom", "McRoom", "Bathroom", "Bedroom") var levelId: int;

@onready var locationNode: Node = %Location;
@onready var fadeControl: FadeInFadeOut = %FadeInFadeOut;
@onready var imageLayer: PuzzleLayerContainer = %ImageLayer;

var currentLocation: Node2D;

func _ready() -> void:
	Global.main_screen = self;
	var starterLevel: Level = LevelContainer.allLevels[levelId];
	setLocation(starterLevel);
	MainEventBus.send_player_to_marker.emit(starterLevel.getMarker("Start"))
	MainEventBus.puzzle_layer_show_scene.connect(turnOnImageLayer);
	MainEventBus.puzzle_layer_exit.connect(turnOffImageLayer)
	MainEventBus.level_change.connect(setLocationWithFade);


func setLocationWithFade(location: Level):
	fadeInFadeOut(func(): setLocation(location));

func setLocation(location: Level):
	for child: Node in locationNode.get_children():
		locationNode.remove_child(child);
	locationNode.add_child(location);
	MainEventBus.level_changed.emit()
	location.player_enters_room.emit();


func fadeInFadeOut(callable: Callable) -> void:
	fadeControl.animation_fade_in_to_object.emit(self)
	fadeControl.animation_fade_in_finished.connect(
		func():
			callable.call()
			fadeControl.animation_fade_out_from_object.emit(self),
		CONNECT_ONE_SHOT
	)

func turnOnImageLayer(controlNode: Control):
	fadeControl.animation_fade_in_to_object.emit(self);
	fadeControl.animation_fade_in_finished.connect(
		showImageAndStartFadeOut,
		CONNECT_ONE_SHOT
		)
	imageLayer.puzzle_layer_set_scene.emit(controlNode);
	pass;

func turnOffImageLayer():
	fadeControl.animation_fade_in_to_object.emit(self);
	fadeControl.animation_fade_in_finished.connect(
		hideImageAndSyatyFadeOut,
		CONNECT_ONE_SHOT
		)
	pass;

func showImageAndStartFadeOut():
	imageLayer.showPuzzleLayer()
	fadeControl.animation_fade_out_from_object.emit(self);
	fadeControl.animation_fade_out_finished.connect(
		func(): imageLayer.startPuzzleView(),
		CONNECT_ONE_SHOT
	)
	pass

func hideImageAndSyatyFadeOut():
	imageLayer.hidePuzzleLayer();
	fadeControl.animation_fade_out_from_object.emit(self);
	fadeControl.animation_fade_out_finished.connect(
		func(): MainEventBus.puzzle_layer_hidden.emit(),
		CONNECT_ONE_SHOT
	)
