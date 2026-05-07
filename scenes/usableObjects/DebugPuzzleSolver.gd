extends Usable

@onready var colorRect: ColorRect = %ColorRect;

const ENABLED_COLOR: Color = Color.WHITE;
const DISABLE_COLOR: Color = Color.CRIMSON;
const HOVER_COLOR: Color = Color.AQUAMARINE;

func _ready() -> void:
	_object_disabled.connect(onDisable);
	_object_enabled.connect(onEnable);
	if(isDisable):
		colorRect.color = DISABLE_COLOR;
	else:
		colorRect.color = ENABLED_COLOR;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func useObject():
	pass;

func onHover():
	colorRect.color = HOVER_COLOR;

func onUnhover():
	if(isDisable):
		colorRect.color = DISABLE_COLOR;
	else:
		colorRect.color = ENABLED_COLOR;

func onDisable():
	colorRect.color = DISABLE_COLOR;
	
func onEnable():
	colorRect.color = ENABLED_COLOR;
