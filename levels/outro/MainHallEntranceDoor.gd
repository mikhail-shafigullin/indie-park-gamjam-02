extends DialogicBackground

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer;
var showDrawing: bool = false;
var showCertificate: bool = false;

func _ready() -> void:
	Dialogic.signal_event.connect(on_signal_event)

func _update_background(argument:String, _time:float) -> void:
	if(argument == "WITHOUT_ITEMS"):
		%CgPuzzle4Scales3Drawing.visible = false;
		%CgPuzzle4Scales4Certificate.visible = false;
	if(argument == "WITH_ITEMS"):
		%CgPuzzle4Scales3Drawing.visible = true;
		%CgPuzzle4Scales4Certificate.visible = true;
	pass;

func on_signal_event(arg: String):
	if arg == 'MainHall_entranceDoorFinishTheGame':
		animationPlayer.play("brake")
		pass;
	pass;
