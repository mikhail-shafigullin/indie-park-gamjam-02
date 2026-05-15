class_name PuzzleLayerContainer 
extends Control

@onready var container: Control = %Container
var currentPuzzle: Control;

signal puzzle_layer_set_scene(controlNode: Control);
signal puzzle_layer_scene_is_updated();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	puzzle_layer_set_scene.connect(setScene)
	set_process_input(false);

func setScene(controlNode: Control) -> void:
	if(currentPuzzle):
		container.remove_child(currentPuzzle)
	currentPuzzle = controlNode
	container.add_child(currentPuzzle)
	puzzle_layer_scene_is_updated.emit();

func showPuzzleLayer() -> void:
	self.visible = true;
	MainEventBus.puzzle_layer_showed.emit();

func hidePuzzleLayer() -> void:
	self.visible = false;
	
func startPuzzleView() -> void:
	Global.currentPuzzle = currentPuzzle;
	set_process_input(true)

func closePuzzleView() -> void:
	Global.currentPuzzle = null;
	set_process_input(false)
	MainEventBus.puzzle_layer_exit.emit();

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		closePuzzleView()
