extends DialogicBackground

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer;

func _ready() -> void:
	Dialogic.signal_event.connect(onDialogicSignal)
	pass;

func _update_background(argument:String, _time:float) -> void:
	if(argument == "walk"):
		animationPlayer.play("walk")
	if(argument == "attack"):
		animationPlayer.play("zoomIn")

func onDialogicSignal(arg: String):
	if arg == "GameOver_Attack":
		animationPlayer.play("zoomIn")
