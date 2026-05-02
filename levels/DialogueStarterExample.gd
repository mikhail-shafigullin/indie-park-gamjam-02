extends Usable

@export var dialogueRes: DialogueResource; 

func _ready() -> void:
	pass

func useObject(): 
	DialogueManager.show_dialogue_balloon(dialogueRes, "start");
	pass;
