extends Usable

var isFirstUse = true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func useObject():
	if(isFirstUse):
		isFirstUse = false;
		Dialogic.start("BedroomItemsUse", "DrawingTake");
		MainEventBus.inventory_add_item.emit(BedroomDrawingItem.new())
		MainEventBus.puzzle_4_solved.emit();
	else:
		Dialogic.start("DefaultMessages", "itemIsAlreadyUsed");
