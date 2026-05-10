extends Node

@export var triggersPuzzle1: Array[TriggerOnGrabable]
@export var triggersPuzzle2: Array[TriggerOnGrabable]
@export var triggersPuzzle3: Array[TriggerOnGrabable]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainEventBus.grabable_object_is_placed_on_trigger.connect(placeObjectOnTrigger)
	pass # Replace with function body.

func placeObjectOnTrigger(trigger: TriggerOnGrabable, grabable: Node2D):
	if(allTriggersResolved(triggersPuzzle1)):
		resolvePuzzle1();
	if(allTriggersResolved(triggersPuzzle2)):
		resolvePuzzle1();
	if(allTriggersResolved(triggersPuzzle3)):
		resolvePuzzle1();
	pass;

func allTriggersResolved(arrayTriggers: Array[TriggerOnGrabable]) -> bool:
	if arrayTriggers.is_empty():
		return false;
	for trigger in arrayTriggers:
		if(!trigger.isResolved): return false;
	return true;

func resolvePuzzle1():
	MainEventBus.puzzle_1_1_solved.emit();

func resolvePuzzle2():
	MainEventBus.puzzle_1_2_solved.emit();

func resolvePuzzle3():
	MainEventBus.puzzle_1_3_solved.emit();
